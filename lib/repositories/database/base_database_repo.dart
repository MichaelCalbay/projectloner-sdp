import 'package:projectloner/models/user_model.dart';

abstract class BaseDatabaseRepository {
  Stream<LonerUser> getUser(String userId);
  Future<String> createUser(LonerUser user);
  Future<void> updateUser(LonerUser user);
  Future<void> updateUserPictures(LonerUser user, String imageName);
}
