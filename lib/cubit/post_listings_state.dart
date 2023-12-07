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
