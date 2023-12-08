import 'package:exercise_json/cubit/post_listings_state.dart';
import 'package:exercise_json/model/post_model.dart';
import 'package:exercise_json/model/users.dart';
import 'package:exercise_json/repository/posts_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersCubit extends Cubit<NoteListingState> {
  final NotesRepository notesRepository;

  UsersCubit({required this.notesRepository}) : super(NoteInitialState());

  fetchUsers() async {
    final _res = await notesRepository.fetchUsers();
    emit(NoteLoadingState());
    if (_res.status) {
      emit(LoadUsersSuccessState(users: _res.data.cast<Users>()));
    } else {
      emit(NoteErrorState(message: _res.message));
    }
  }
}
