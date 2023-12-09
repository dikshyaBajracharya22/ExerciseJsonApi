import 'package:exercise_json/cubit/comments_cubit.dart';
import 'package:exercise_json/cubit/post_listings_cubit.dart';
import 'package:exercise_json/cubit/post_listings_state.dart';
import 'package:exercise_json/cubit/users_cubit.dart';
import 'package:exercise_json/model/todos.dart';
import 'package:exercise_json/ui/screen/comments_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/todos_cubit.dart';
import '../screen/user_screen.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NoteListingCubit>().fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteListingCubit, NoteListingState>(
      listener: ((context, state) {
        if (state is NoteSuccessState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Success")));
        } else if (state is NoteErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
            "Error Occuredd",
            maxLines: 1,
          )));
        }
      }),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  context.read<UsersCubit>().fetchUsers();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const UserScreen();
                  }));
                },
                icon: const Icon(Icons.person)),
          ],
          title: const Text(
            "Posts App",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          elevation: 0,
          backgroundColor: Colors.green[300],
        ),
        body: BlocBuilder<NoteListingCubit, NoteListingState>(
            builder: (context, state) {
          if (state is NoteLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NoteErrorState) {
            return Container(
              child: Text(state.message),
            );
          } else if (state is NoteSuccessState) {
            return ListView.builder(
                itemCount: state.notes.length,
                itemBuilder: ((context1, index) {
                  return Container(
                    // margin: EdgeInsets.symmetric(vertical: 1),
                    child: Card(
                      color: Color.fromARGB(255, 233, 243, 234),
                      elevation: 5,
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        onTap: () async {
                          context
                              .read<CommentListingCubit>()
                              .fetchComments(state.notes[index].id);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return CommentsScreen(
                              title: state.notes[index].title,
                              id: state.notes[index].id,
                            );
                          }));
                        },
                        leading: const Image(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/post.jpg")),
                        title: Text(
                          state.notes[index].title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 19),
                        ),
                        subtitle: Container(
                          margin: const EdgeInsets.only(top: 7),
                          child: Text(
                            state.notes[index].body,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                        trailing: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.delete)),
                      ),
                    ),
                  );
                }));
          } else {
            return Container();
          }
        }),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text(
    //       "My Exercise App",
    //       style: TextStyle(
    //           color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500),
    //     ),
    //     elevation: 0,
    //     backgroundColor: Colors.grey,
    //   ),
    //   body: Column(
    //     children: const [
    //       Text("MyaPP"),

    //     ],
    //   ),
    // );
  }
}
