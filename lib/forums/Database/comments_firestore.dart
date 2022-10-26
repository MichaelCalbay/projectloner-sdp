import 'package:cloud_firestore/cloud_firestore.dart';

class CommentStore {
  static likeToComment(String postID, String commentID, String userName) async {
    await FirebaseFirestore.instance
        .collection('Forums')
        .doc(postID)
        .collection('Comments')
        .doc(commentID)
        .collection('Likes')
        .doc(userName)
        .set({
      'commentID': commentID,
      'commentLiker': userName,
    });
  }

  static unlikeToComment(
      String postID, String commentID, String userName) async {
    await FirebaseFirestore.instance
        .collection('Forums')
        .doc(postID)
        .collection('Comments')
        .doc(commentID)
        .collection('Likes')
        .doc(userName)
        .delete();
  }

  static incrementCommentLikeCount(DocumentSnapshot data) async {
    data.reference.update(
      {'commentLikeCount': FieldValue.increment(1)},
    );
  }

  static decrementCommentLikeCount(DocumentSnapshot data) async {
    data.reference.update(
      {'commentLikeCount': FieldValue.increment(-1)},
    );
  }

  static Future<bool> checkIfLiked(
      String postID, String commentID, String userName) async {
    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection('Forums')
        .doc(postID)
        .collection('Comments')
        .doc(commentID)
        .collection('Likes')
        .doc(userName)
        .get();

    return ds.exists;
  }
}
