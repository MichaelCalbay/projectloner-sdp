import 'package:cloud_firestore/cloud_firestore.dart';

class ForumsStore {
  static Future commentToPost(
      String postID, String commentContent, String userName) async {
    await FirebaseFirestore.instance
        .collection('Forums')
        .doc(postID)
        .collection('Comments')
        .doc()
        .set({
      'postID': postID,
      'commentUserName': userName,
      'commentTimeStamp': DateTime.now().microsecondsSinceEpoch,
      'commentContent': commentContent,
      'commentLikeCount': 0,
    });
  }

  static Future likeToPost(String postID, String userName) async {
    await FirebaseFirestore.instance
        .collection('Forums')
        .doc(postID)
        .collection('Likes')
        .doc(userName)
        .set({
      'postID': postID,
      'commentUserName': userName,
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
