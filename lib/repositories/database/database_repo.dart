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
}
