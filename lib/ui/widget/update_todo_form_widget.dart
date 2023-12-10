import 'package:exercise_json/cubit/add_todos_cubit.dart';
import 'package:exercise_json/cubit/post_listings_state.dart';
import 'package:exercise_json/cubit/update_todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateTodoFormWidget extends StatefulWidget {
  final int userId;
  const UpdateTodoFormWidget({super.key, required this.userId});

  @override
  State<UpdateTodoFormWidget> createState() => _UpdateTodoFormWidgetState();
}

class _UpdateTodoFormWidgetState extends State<UpdateTodoFormWidget> {
  TextEditingController titleController = TextEditingController();
  bool? selectedstatus;

  @override
  Widget build(BuildContext context) {
    List<bool?> options = [null, true, false];
    return BlocListener<UpdateTodoCubit, NoteListingState>(
      listener: (context, state) {
        if (state is UpdateTodoSuccessState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Successfully todo updated")));
        } else if (state is NoteErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Unable to update todo")));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Update Todo Form",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          elevation: 0,
          backgroundColor: Colors.green[300],
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: const Icon(Icons.mode_edit),
                title: TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(hintText: "Title of Todo"),
                ),
              ),
              // Text("Name"),

              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: const Icon(Icons.task_alt),
                title: DropdownButton<bool?>(
                  value: selectedstatus,
                  items: options.map((bool? value) {
                    return DropdownMenuItem<bool?>(
                      value: value,
                      child: Text(value == null
                          ? "completed status"
                          : value.toString()),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedstatus = newValue!;
                    });
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
                child: MaterialButton(
                  color: Colors.red,
                  onPressed: () async {
                    context.read<UpdateTodoCubit>().updateTodos(
                        userId: widget.userId,
                        title: titleController.text,
                        completed: selectedstatus!);
                  },
                  child: const Text(
                    "Update Todo",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


