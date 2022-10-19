import 'package:projectloner/models/user_model.dart';

abstract class BaseDatabaseRepository {
  Stream<LonerUser> getUser(String userId);
  Stream<List<LonerUser>> getUsers(LonerUser user);
  Future<void> createUser(LonerUser user);
  Future<void> updateUser(LonerUser user);
  Future<void> updateUserPictures(LonerUser user, String imageName);
  Future<void> updateUserSwipes(
    String userId,
    String matchId,
    bool isSwipedRight,
  );
  Future<void> updateUserMatches(String userId, String matchId);
}
