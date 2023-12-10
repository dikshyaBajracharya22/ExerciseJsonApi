import 'package:exercise_json/cubit/post_listings_state.dart';
import 'package:exercise_json/model/todos.dart';
import 'package:exercise_json/repository/posts_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateTodoCubit extends Cubit<NoteListingState> {
  final NotesRepository notesRepository;
  UpdateTodoCubit({required this.notesRepository}) : super(NoteInitialState());

  updateTodos(
      {required userId, required title, required bool completed}) async {
    emit(NoteLoadingState());
    final _res = await notesRepository.updateTodo(
        userId: userId, title: title, completed: completed);
    if (_res.status) {
      emit(UpdateTodoSuccessState(todos: _res.data.cast<Todos>()));
    } else {
      emit(NoteErrorState(message: _res.message));
    }
  }
}
