import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

import '../widget/add_comment_form_widget.dart';

class AddCommentScreen extends StatelessWidget {
  final int postId;
  const AddCommentScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return AddCommentWidget(postId: postId,);
  }
}