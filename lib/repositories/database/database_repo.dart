import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectloner/models/user_model.dart';
import 'package:projectloner/repositories/database/base_database_repo.dart';
import 'package:projectloner/repositories/storage/storage_repo.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<LonerUser> getUser(String userId) {
    return _firebaseFirestore
        .collection('LonerUser')
        .doc(userId)
        .snapshots()
        .map((snap) => LonerUser.fromSnapshot(snap));
  }

  @override
  Future<void> updateUserPictures(LonerUser user, String imageName) async {
    String downloadUrl = await StorageRepo().getDownloadUrl(user, imageName);

    return _firebaseFirestore.collection('LonerUser').doc(user.id).update({
      'imageUrls': FieldValue.arrayUnion([downloadUrl])
    });
  }

  @override
  Future<void> createUser(LonerUser user) async {
    await _firebaseFirestore
        .collection('LonerUser')
        .doc(user.id)
        .set(user.toMap());
  }

  @override
  Future<void> updateUser(LonerUser user) {
    return _firebaseFirestore
        .collection('LonerUser')
        .doc(user.id)
        .update(user.toMap())
        .then((value) => debugPrint('User Updated!'));
  }

  @override
  Stream<List<LonerUser>> getUsers(LonerUser user) {
    List<String> userFilters = List.from(user.swipedLeft!)
      ..addAll(user.swipedRight!)
      ..add(user.id!);
    return _firebaseFirestore
        .collection('LonerUser')
        .where('gender', isEqualTo: 'Female')
        .where(FieldPath.documentId, whereNotIn: userFilters)
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) => LonerUser.fromSnapshot(doc)).toList();
    });
  }

  @override
  Future<void> updateUserSwipes(
    String userId,
    String matchId,
    bool isSwipedRight,
  ) async {
    if (isSwipedRight) {
      await _firebaseFirestore.collection('LonerUser').doc(userId).update({
        'swipedRight': FieldValue.arrayUnion([matchId])
      });
    } else {
      await _firebaseFirestore.collection('LonerUser').doc(userId).update({
        'swipedLeft': FieldValue.arrayUnion([matchId])
      });
    }
  }

  @override
  Future<void> updateUserMatches(String userId, String matchId) async {
    //This will update the currently logged in user's matches.
    await _firebaseFirestore.collection('LonerUser').doc(userId).update({
      'matches': FieldValue.arrayUnion([matchId])
    });

    //This will update the other user's match on their end as well.
    await _firebaseFirestore.collection('LonerUser').doc(matchId).update({
      'matches': FieldValue.arrayUnion([userId])
    });
  }
}
