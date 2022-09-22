import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectloner/models/user_model.dart';
import 'package:projectloner/repositories/database/base_database_repo.dart';
import 'package:projectloner/repositories/storage/storage_repo.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<LonerUser> getUser() {
    return _firebaseFirestore
        .collection('LonerUser')
        .doc('sSTfiTTYiWp7xqWnULEo')
        .snapshots()
        .map((snap) => LonerUser.fromSnapshot(snap));
  }

  @override
  Future<void> updateUserPictures(String imageName) async {
    String downloadUrl = await StorageRepo().getDownloadUrl(imageName);

    return _firebaseFirestore
        .collection('LonerUser')
        .doc('sSTfiTTYiWp7xqWnULEo')
        .update({
      'imageUrls': FieldValue.arrayUnion([downloadUrl])
    });
  }
}
