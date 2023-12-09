import 'package:exercise_json/cubit/add_comment_cubit.dart';
import 'package:exercise_json/cubit/add_todos_cubit.dart';
import 'package:exercise_json/cubit/comments_cubit.dart';
import 'package:exercise_json/cubit/post_listings_cubit.dart';
import 'package:exercise_json/cubit/todos_cubit.dart';
import 'package:exercise_json/cubit/users_cubit.dart';
import 'package:exercise_json/repository/posts_repo.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiBlocWrapper extends StatelessWidget {
  final Widget child;
  const MultiBlocWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) => NoteListingCubit(
              notesRepository:
                  RepositoryProvider.of<NotesRepository>(context))),
      BlocProvider(
          create: (context) => CommentListingCubit(
              notesRepository:
                  RepositoryProvider.of<NotesRepository>(context))),
      BlocProvider(
          create: (context) => AddCommentCubit(
              notesRepository:
                  RepositoryProvider.of<NotesRepository>(context))),
      BlocProvider(
          create: (context) => UsersCubit(
              notesRepository:
                  RepositoryProvider.of<NotesRepository>(context))),
      BlocProvider(
          create: (context) => TodosCubit(
              notesRepository:
                  RepositoryProvider.of<NotesRepository>(context))),
      BlocProvider(
          create: (context) => AddTodosCubit(
              notesRepository:
                  RepositoryProvider.of<NotesRepository>(context))),
    ], child: child);
  }
}
