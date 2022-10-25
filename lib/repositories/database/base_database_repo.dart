import '../../models/models.dart';

abstract class BaseDatabaseRepository {
  Stream<LonerUser> getUser(String userId);
  Stream<Chat> getChat(String chatId);
  Stream<List<LonerUser>> getUsersToMatch(LonerUser user);
  Stream<List<LonerUser>> getUsers(LonerUser user);
  Stream<List<UserMatch>> getMatches(LonerUser user);
  Stream<List<Chat>> getChats(String userId);
  Future<void> createUser(LonerUser user);
  Future<void> updateUser(LonerUser user);
  Future<void> updateUserPictures(LonerUser user, String imageName);
  Future<void> updateUserSwipes(
    String userId,
    String matchId,
    bool isSwipedRight,
  );
  Future<void> updateUserMatches(String userId, String matchId);
  Future<void> addMessage(String chatId, Message message);
}
