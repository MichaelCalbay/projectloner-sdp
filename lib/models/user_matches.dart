import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models.dart';

class UserMatch extends Equatable {
  final String userId;
  final LonerUser matchedUser;
  final List<Chat>? chat;

  const UserMatch({
    required this.userId,
    required this.matchedUser,
    this.chat,
  });

  static UserMatch fromSnapshot(DocumentSnapshot snap, String userId) {
    UserMatch match = UserMatch(
      userId: userId,
      matchedUser: LonerUser.fromSnapshot(snap),
    );

    return match;
  }

  UserMatch copyWith({
    String? userId,
    LonerUser? matchedUser,
    List<Chat>? chat,
  }) {
    return UserMatch(
      userId: userId ?? this.userId,
      matchedUser: matchedUser ?? this.matchedUser,
      chat: chat ?? this.chat,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        matchedUser,
        chat,
      ];

  //SAMPLE DATA FOR TESTING.
  static List<UserMatch> matches = [
    UserMatch(
      userId: '1',
      matchedUser: LonerUser.users[1],
      // chat: Chat.chats
      //     .where((chat) => chat.userId == 1 && chat.matchedUserId == 1)
      //     .toList(),
    ),
  ];
}
