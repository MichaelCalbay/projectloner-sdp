import 'package:cloud_firestore/cloud_firestore.dart';

class CommentData {
  static Future commentToPost(String postID, String commentContent) async {
    await FirebaseFirestore.instance
        .collection('Forums')
        .doc(postID)
        .collection('Comment')
        .doc()
        .set({
      'postID': postID,
      'Name': 'Nelson',
      'commentTimeStamp': DateTime.now().microsecondsSinceEpoch,
      'commentContent': commentContent,
      'commentLikeCount': 0,
    });
  }

  static Future updatePostCommentCount(DocumentSnapshot data) async {
    data.reference.update(
      {'postCommentCounter': FieldValue.increment(1)},
    );
  }

  static Future updatePostLikeCount(DocumentSnapshot data) async {
    data.reference.update(
      {'postLikeCounter': FieldValue.increment(1)},
    );
  }
}
