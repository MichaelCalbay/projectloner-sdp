import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectloner/models/user_model.dart';
import 'package:projectloner/repositories/database/base_database_repo.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<LonerUser> getUser() {
    return _firebaseFirestore
        .collection('LonerUser')
        .doc('aEpbDbKSVpAdUmsQyMzg')
        .snapshots()
        .map((snap) => LonerUser.fromSnapshot(snap));
  }
}
