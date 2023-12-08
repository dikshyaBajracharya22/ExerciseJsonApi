import 'package:exercise_json/cubit/add_comment_cubit.dart';
import 'package:exercise_json/cubit/comments_cubit.dart';
import 'package:exercise_json/cubit/post_listings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCommentWidget extends StatefulWidget {
  final int postId;
  const AddCommentWidget({super.key, required this.postId});

  @override
  State<AddCommentWidget> createState() => _AddCommentWidgetState();
}

class _AddCommentWidgetState extends State<AddCommentWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCommentCubit, NoteListingState>(
      listener: (context, state) {
        if (state is NoteLoadingState) {
          const Center(child: CircularProgressIndicator());
        } else if (state is AddCommentsSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Succesffuly Comment Added")));
        } else if (state is NoteErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Error while adding comment")));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Add Comment Form",
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
                leading: const Icon(Icons.person),
                title: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(hintText: "Name"),
                ),
              ),
              // Text("Name"),

              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: const Icon(Icons.mail),
                title: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: "Email Address"),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: TextFormField(
                  controller: _bodyController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      hintText: "Comment", border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: MaterialButton(
                  color: Colors.red,
                  onPressed: () async {
                    context.read<AddCommentCubit>().addComments(
                        name: _nameController.text,
                        email: _emailController.text,
                        body: _bodyController.text,
                        postId: widget.postId,
                        );
                  },
                  child: const Text(
                    "Save Comment",
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
