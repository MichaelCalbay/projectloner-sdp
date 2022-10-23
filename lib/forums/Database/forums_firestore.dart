import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';


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
      'commentTimeStamp': DateTime.now().millisecondsSinceEpoch,
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

  static Future<String> uploadPostImages({required String postID,required File postImageFile}) async {
    try {
      //FirebaseStorage storage = FirebaseStorage.instance;
      String fileName = 'images/$postID/postImage';
      Reference reference = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = reference.putFile(postImageFile);
      TaskSnapshot storageTaskSnapshot = await uploadTask;
      String postImageURL = await storageTaskSnapshot.ref.getDownloadURL();
      return postImageURL;
    }catch(e) {
      return 'error';
    }
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
