import 'package:exercise_json/cubit/post_listings_state.dart';
import 'package:exercise_json/cubit/todos_cubit.dart';
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
        child: BlocListener<TodosCubit, NoteListingState>(
          listener: (context, state) {
            if (state is LoadTodosSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Succesfully Loaded Todos")));
            } else if (state is NoteErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Succesfully Loaded Todos")));
            }
          },
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
            body: TabBarView(children: [
              BlocBuilder<TodosCubit, NoteListingState>(
                builder: (context, state) {
                  if (state is NoteLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is LoadTodosSuccessState) {
                    return ListView.builder(
                        itemCount: state.todos.length,
                        itemBuilder: (context1, index) {
                          return Card(
                            color: const Color.fromARGB(255, 233, 243, 234),
                            elevation: 3,
                            margin: const EdgeInsets.all(8),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                                      ],
                                    ),
                                  ),
                                  state.todos[index].completed
                                      ? Icon(Icons.task_alt)
                                      : Icon(Icons.highlight_off),
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
        ));
  }
}
