import 'package:exercise_json/model/comments.dart';
import 'package:flutter/widgets.dart';

import '../model/post_model.dart';

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
