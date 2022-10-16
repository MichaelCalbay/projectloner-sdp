import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentButton extends StatelessWidget {
  final DocumentSnapshot data;
  const CommentButton({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(Icons.mode_comment),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Comment(${data['postCommentCounter']})',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
