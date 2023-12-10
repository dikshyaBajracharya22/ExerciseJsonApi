
import 'package:exercise_json/cubit/post_listings_state.dart';
import 'package:exercise_json/model/comments.dart';
import 'package:exercise_json/model/todos.dart';
import 'package:exercise_json/repository/posts_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteTodoCubit extends Cubit<NoteListingState>{
  final NotesRepository notesRepository;
  DeleteTodoCubit({required this.notesRepository,}): super(NoteInitialState());

  deleteTodo({required id})async{
    final _res=await notesRepository.deleteTodo(id: id);
    emit(NoteLoadingState());
    if(_res.status){
        emit(DeleteSuccessState(todo: _res.data.cast<Todos>()));
    }else{
      emit(NoteErrorState(message: _res.message));
    }
  }
}