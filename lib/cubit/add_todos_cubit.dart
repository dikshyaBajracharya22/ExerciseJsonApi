import 'package:exercise_json/cubit/post_listings_state.dart';
import 'package:exercise_json/repository/posts_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/todos.dart';

class AddTodosCubit extends Cubit<NoteListingState> {
  final NotesRepository notesRepository;
  AddTodosCubit({required this.notesRepository}) : super(NoteInitialState());

  addTodos({required userId, required title, required bool completed}) async {
    emit(NoteLoadingState());
    final _res = await notesRepository.addTodo(
        userId: userId, title: title, completed: completed);
    if (_res.status) {
      emit(AddTodoSuccessState(todos: _res.data.cast<Todos>()));
    } else {
      emit(NoteErrorState(message: _res.message));
    }
  }
}
