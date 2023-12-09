import 'package:exercise_json/model/comments.dart';
import 'package:exercise_json/model/todos.dart';
import 'package:flutter/widgets.dart';

import '../model/post_model.dart';
import '../model/users.dart';

abstract class NoteListingState {}

class NoteInitialState extends NoteListingState {}

class NoteLoadingState extends NoteListingState {}

class NoteErrorState extends NoteListingState {
  final String message;

  NoteErrorState({required this.message});
}

class NoteSuccessState extends NoteListingState {
  final List<Notes> notes;

  NoteSuccessState({required this.notes});
}

class CommentSuccessState extends NoteListingState {
  final List<Comments> comments;
  CommentSuccessState({required this.comments});
}

class AddCommentsSuccessState extends NoteListingState {
  final List<Comments> addComments;
  AddCommentsSuccessState({required this.addComments});
}

class LoadUsersSuccessState extends NoteListingState {
  final List<Users> users;
  LoadUsersSuccessState({required this.users});
}

class LoadTodosSuccessState extends NoteListingState {
  final List<Todos> todos;
  LoadTodosSuccessState({required this.todos});
}
