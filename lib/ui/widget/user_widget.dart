import 'package:exercise_json/cubit/post_listings_state.dart';
import 'package:exercise_json/cubit/todos_cubit.dart';
import 'package:exercise_json/cubit/users_cubit.dart';
import 'package:exercise_json/ui/screen/user_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserWidget extends StatefulWidget {
  const UserWidget({super.key});

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersCubit, NoteListingState>(
      listener: (context, state) {
        if (state is LoadUsersSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("User Loaded Successfully")));
        } else if (state is NoteErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Error Loading Users")));
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Users",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            elevation: 0,
            backgroundColor: Colors.green[300],
          ),
          body: BlocBuilder<UsersCubit, NoteListingState>(
              builder: (context, state) {
            if (state is NoteLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadUsersSuccessState) {
              return ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context1, index) {
                    return InkWell(
                      onTap: () {
                        context
                            .read<TodosCubit>()
                            .loadTodos(userId: state.users[index].id);
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return UserDetailScreen(
                            userId: state.users[index].id,
                          );
                        }));
                      },
                      child: Card(
                        color: const Color.fromARGB(255, 233, 243, 234),
                        elevation: 3,
                        margin: const EdgeInsets.all(8),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.users[index].name,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17),
                                    ),
                                    Text(state.users[index].email,
                                        style: const TextStyle(
                                            color: Colors.black87)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 7),
                                      child: Text(
                                          state.users[index].address.street,
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.people)
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Container();
            }
          })),
    );
  }
}
