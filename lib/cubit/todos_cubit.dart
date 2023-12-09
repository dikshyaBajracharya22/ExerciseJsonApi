import 'package:exercise_json/cubit/post_listings_state.dart';
import 'package:exercise_json/repository/posts_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/todos.dart';

class TodosCubit extends Cubit<NoteListingState> {
  final NotesRepository notesRepository;
  TodosCubit({required this.notesRepository}) : super(NoteInitialState());

  loadTodos({required userId}) async {
    emit(NoteLoadingState());
    final _res = await notesRepository.loadTodos(userId: userId);
    if (_res.status) {
      emit(LoadTodosSuccessState(todos: _res.data.cast<Todos>()));
    } else {
      emit(NoteErrorState(message: _res.message));
    }
  }
}
