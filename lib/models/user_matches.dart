import 'package:equatable/equatable.dart';

import 'models.dart';

class UserMatch extends Equatable {
  final int id;
  final int userId;
  final LonerUser matchedUser;
  final List<Chat>? chat;

  const UserMatch({
    required this.id,
    required this.userId,
    required this.matchedUser,
    required this.chat,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        matchedUser,
      ];

  //SAMPLE DATA FOR TESTING.

  static List<UserMatch> matches = [
    UserMatch(
      id: 1,
      userId: 1,
      matchedUser: LonerUser.users[1],
      chat: Chat.chats
          .where((chat) => chat.userId == 1 && chat.matchedUserId == 2)
          .toList(),
    ),
    UserMatch(
      id: 2,
      userId: 1,
      matchedUser: LonerUser.users[5],
      chat: Chat.chats
          .where((chat) => chat.userId == 1 && chat.matchedUserId == 6)
          .toList(),
    ),
    UserMatch(
      id: 3,
      userId: 1,
      matchedUser: LonerUser.users[2],
      chat: Chat.chats
          .where((chat) => chat.userId == 1 && chat.matchedUserId == 3)
          .toList(),
    ),
    UserMatch(
      id: 4,
      userId: 1,
      matchedUser: LonerUser.users[3],
      chat: Chat.chats
          .where((chat) => chat.userId == 1 && chat.matchedUserId == 4)
          .toList(),
    ),
    UserMatch(
      id: 5,
      userId: 1,
      matchedUser: LonerUser.users[4],
      chat: Chat.chats
          .where((chat) => chat.userId == 1 && chat.matchedUserId == 5)
          .toList(),
    ),
  ];
}
