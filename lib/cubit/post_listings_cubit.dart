import 'package:bloc/bloc.dart';
import 'package:exercise_json/cubit/post_listings_state.dart';
import 'package:meta/meta.dart';

import '../model/post_model.dart';
import '../repository/posts_repo.dart';

class NoteListingCubit extends Cubit<NoteListingState> {
  final NotesRepository notesRepository;

  NoteListingCubit({required this.notesRepository}) : super(NoteInitialState());
  fetchNotes() async {
    emit(NoteLoadingState());
    final _res = await notesRepository.fetchNotes();
    if (_res.status) {
      emit(NoteSuccessState(notes: _res.data.cast<Notes>()));
    } else {
      emit(NoteErrorState(message: _res.message));
    }
  }
}
