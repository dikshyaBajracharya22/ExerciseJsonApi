import 'package:exercise_json/cubit/add_todos_cubit.dart';
import 'package:exercise_json/cubit/delete_cubit.dart';
import 'package:exercise_json/cubit/post_listings_state.dart';
import 'package:exercise_json/cubit/todos_cubit.dart';
import 'package:exercise_json/ui/screen/add_todo_form_screen.dart';
import 'package:exercise_json/ui/widget/add_todo_form_widget.dart';
import 'package:exercise_json/ui/widget/update_todo_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailWidget extends StatefulWidget {
  final int userId;
  const UserDetailWidget({super.key, required this.userId});

  @override
  State<UserDetailWidget> createState() => _UserDetailWidgetState();
}

class _UserDetailWidgetState extends State<UserDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: MultiBlocListener(
          listeners: [
            BlocListener<TodosCubit, NoteListingState>(
              listener: (context, state) {
                if (state is LoadTodosSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Succesfully Loaded Todos")));
                } else if (state is NoteErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Unable to load Todos")));
                }
              },
            ),
            BlocListener<DeleteTodoCubit, NoteListingState>(
              listener: (context, state) {
                if (state is DeleteSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Succesfully Deleted Todo")));
                } else if (state is NoteErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Unable to delete Todos")));
                }
              },
            ),
          ],
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                  unselectedLabelStyle: TextStyle(color: Colors.amberAccent),
                  tabs: [
                    Tab(text: "Todos"),
                    Tab(text: "Albums"),
                    Tab(text: "Posts")
                  ]),
              centerTitle: true,
              title: const Text(
                "Users Information",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              elevation: 0,
              backgroundColor: Colors.green[300],
            ),
            body: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  width: 125,
                  margin: EdgeInsets.only(left: 220),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return AddTodoScreen(
                          userId: widget.userId,
                        );
                      }));
                    },
                    color: Colors.green,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Add Todo",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    BlocBuilder<TodosCubit, NoteListingState>(
                      builder: (context, state) {
                        if (state is NoteLoadingState) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is LoadTodosSuccessState) {
                          return ListView.builder(
                              itemCount: state.todos.length,
                              itemBuilder: (context1, index) {
                                return Card(
                                  color:
                                      const Color.fromARGB(255, 233, 243, 234),
                                  elevation: 3,
                                  margin: const EdgeInsets.all(8),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${state.todos[index].title}",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                  "completed: ${state.todos[index].completed.toString()}",
                                                  style: const TextStyle(
                                                      color: Colors.black87)),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    child: MaterialButton(
                                                      color: Colors
                                                          .blueAccent.shade100,
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return UpdateTodoFormWidget(
                                                              userId: state
                                                                  .todos[index]
                                                                  .id);
                                                        }));
                                                      },
                                                      child: Container(
                                                        // width: 140,

                                                        child: Row(
                                                          children: const [
                                                            Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              "Update Todo",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  // SizedBox(
                                                  //   width: 40,
                                                  // ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        state.todos[index].completed
                                            ? Icon(Icons.task_alt)
                                            : Icon(Icons.highlight_off),
                                        InkWell(
                                          onTap: () {
                                            context
                                                .read<DeleteTodoCubit>()
                                                .deleteTodo(
                                                    id: state.todos[index].id);
                                          },
                                          child: Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return Container();
                        }
                      },
                    ),
                    Container(
                      child: Text("Albums"),
                    ),
                    Container(
                      child: Text("Posts"),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ));
  }
}
