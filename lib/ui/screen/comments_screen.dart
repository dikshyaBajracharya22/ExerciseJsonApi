import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../widget/comments_widget.dart';

class CommentsScreen extends StatelessWidget {
  final String title;
  const CommentsScreen({super.key, required this.title,});

  @override
  Widget build(BuildContext context) {
    return CommentsWidget(title: title,
    );
  }
}
