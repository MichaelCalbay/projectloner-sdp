import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectloner/forum/posts_model.dart';

class PostService{

  List<PostModel> _postListFromSnapShot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){ //iterates returns an object
      return PostModel(
          id: doc.id,
          text: doc.get('text') ?? '', //if empty
          user: doc.get('user') ?? '',
          timestamp: doc.get('timestamp') ?? 0,
      );
    }).toList();
  }
  Future savePost(text) async{
    await FirebaseFirestore.instance.collection("Forums").add({
      'text': text,
      'user': FirebaseAuth.instance.currentUser?.uid,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<PostModel>> getPostsByUser(uid){

    return FirebaseFirestore.instance
        .collection("Forums")
        .where('user', isEqualTo: uid)
        .snapshots()
        .map(_postListFromSnapShot);

  }
}