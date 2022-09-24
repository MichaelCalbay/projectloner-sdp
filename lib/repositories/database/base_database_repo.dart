import 'package:projectloner/models/user_model.dart';

abstract class BaseDatabaseRepository {
  Stream<LonerUser> getUser();
  // Future<void> updateUserPictures(String imageName);
}
