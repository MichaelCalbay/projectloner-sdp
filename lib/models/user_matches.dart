import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models.dart';

class UserMatch extends Equatable {
  final String userId;
  final LonerUser matchedUser;
  final Chat chat;

  const UserMatch({
    required this.userId,
    required this.matchedUser,
    this.chat,
  });
  UserMatch copyWith({
    String? userId,
    LonerUser? matchedUser,
    Chat? chat,
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
}
