import 'package:exercise_json/cubit/comments_cubit.dart';
import 'package:exercise_json/cubit/post_listings_state.dart';
import 'package:exercise_json/ui/screen/add_comment_form_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsWidget extends StatefulWidget {
  final String title;
  final int id;
  const CommentsWidget({super.key, required this.title, required this.id});

  @override
  State<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CommentListingCubit, NoteListingState>(
      listener: (context, state) {
        if (state is NoteSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Comment Fetched Successfully")));
        } else if (state is NoteErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Error Occured while comment fetching")));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Posts Comments",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          elevation: 0,
          backgroundColor: Colors.green[300],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Container(
              alignment: Alignment.center,
              height: 200,
              width: 350,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/post.jpg"))),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
                margin: EdgeInsets.only(left: 27),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                )),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 27),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.comment,
                  ),
                  const Text(
                    "Comments",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    width: 22,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return AddCommentScreen(
                          postId: widget.id,
                        );
                      }));
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 4,
                      ),
                      height: 30,
                      width: 160,
                      color: Colors.green.shade500,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.add_comment,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Add Comment",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: BlocBuilder<CommentListingCubit, NoteListingState>(
                  builder: (context, state) {
                if (state is NoteLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NoteErrorState) {
                  return Container(
                    child: Text(state.message),
                  );
                } else if (state is CommentSuccessState) {
                  return ListView.builder(
                      itemCount: state.comments.length,
                      itemBuilder: ((context3, index) {
                        return Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Card(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.comments[index].name,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 17),
                                            ),
                                            Text(state.comments[index].email,
                                                style: const TextStyle(
                                                    color: Colors.black87)),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(right: 7),
                                              child: Text(
                                                  state.comments[index].body,
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
                            )
                          ],
                        );
                      }));
                } else {
                  return Container();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
