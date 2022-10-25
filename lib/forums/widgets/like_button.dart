import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectloner/forums/forums_view.dart';

class LikeButton extends StatelessWidget {
  final DocumentSnapshot data;
  final Future<bool> isPostLiked;
  const LikeButton({
    required this.data,
    required this.isPostLiked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isPostLiked,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Row(
          children: [
            snapshot.data!
                ? const Icon(
                    Icons.thumb_up,
                    color: Colors.deepPurple,
                  )
                : const Icon(
                    Icons.thumb_up,
                  ),
            snapshot.data!
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Unlike(${data['postLikeCounter']})',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Like(${data['postLikeCounter']})',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )
          ],
        );
      },
    );
  }
}
