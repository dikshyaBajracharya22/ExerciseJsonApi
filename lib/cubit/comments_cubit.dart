import 'package:exercise_json/cubit/post_listings_state.dart';
import 'package:exercise_json/model/comments.dart';
import 'package:exercise_json/repository/posts_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentListingCubit extends Cubit<NoteListingState> {
  final NotesRepository notesRepository;
  CommentListingCubit({required this.notesRepository})
      : super(NoteInitialState());

  fetchComments(int post_id) async {
    emit(NoteLoadingState());
    final _res = await notesRepository.fetchComments(post_id);
    if (_res.status) {
      emit(CommentSuccessState(comments: _res.data.cast<Comments>()));
    } else {
      emit(NoteErrorState(message: _res.message));
    }
  }
}
