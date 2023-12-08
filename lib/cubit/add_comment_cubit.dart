
import 'package:exercise_json/cubit/post_listings_state.dart';
import 'package:exercise_json/model/comments.dart';
import 'package:exercise_json/repository/posts_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCommentCubit extends Cubit<NoteListingState>{
  final NotesRepository notesRepository;
  AddCommentCubit({required this.notesRepository,}): super(NoteInitialState());

  addComments({required name, required email, required body, required postId})async{
    final _res=await notesRepository.addComments(name: name, email: email, body: body, postId: postId);
    emit(NoteLoadingState());
    if(_res.status){
        emit(AddCommentsSuccessState(addComments: _res.data.cast<Comments>()));
    }else{
      emit(NoteErrorState(message: _res.message));
    }
  }
}