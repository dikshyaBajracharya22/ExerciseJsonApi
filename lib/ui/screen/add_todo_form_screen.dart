import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../widget/add_todo_form_widget.dart';

class AddTodoScreen extends StatelessWidget {
  final int userId;
  const AddTodoScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return AddTodoWidget(userId: userId,);
  }
}