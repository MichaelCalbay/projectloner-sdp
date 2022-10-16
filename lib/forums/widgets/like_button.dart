import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final DocumentSnapshot data;
  const LikeButton({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(Icons.thumb_up),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Like(${data['postLikeCounter']})',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
