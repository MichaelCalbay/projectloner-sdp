import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectloner/forums/Database/comment_data.dart';

class CommentComposer extends StatelessWidget {
  final TextEditingController _msgController = TextEditingController();
  final DocumentSnapshot data;
  CommentComposer({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _msgController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                    hintText: 'Write a comment...'),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              child: IconButton(
                onPressed: (() {
                  _handleSubmitted(_msgController.text);
                }),
                icon: const Icon(
                  Icons.send,
                  color: Colors.deepPurple,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _handleSubmitted(String text) async {
    try {
      await CommentData.commentToPost(data['postID'], _msgController.text);
      await CommentData.updatePostCommentCount(data);
    } catch (e) {}
  }
}
