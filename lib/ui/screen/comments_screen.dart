import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../widget/comments_widget.dart';

class CommentsScreen extends StatelessWidget {
  final String title;
  final int id;
  const CommentsScreen({super.key, required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return CommentsWidget(title: title,id: id,
    );
  }
}
