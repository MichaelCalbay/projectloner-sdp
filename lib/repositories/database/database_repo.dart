import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectloner/repositories/database/base_database_repo.dart';
import 'package:projectloner/repositories/storage/storage_repo.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/models.dart';

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
  Future<void> addMessage(String chatId, Message message) {
    return _firebaseFirestore.collection('Chats').doc(chatId).update({
      'messages': FieldValue.arrayUnion([
        message.toJson(),
      ])
    });
  }

  @override
  Stream<Chat> getChat(String chatId) {
    return _firebaseFirestore
        .collection('Chats')
        .doc(chatId)
        .snapshots()
        .map((doc) => Chat.fromJson(
              doc.data() as Map<String, dynamic>,
              id: doc.id,
            ));
  }

  @override
  Stream<List<Chat>> getChats(String userId) {
    return _firebaseFirestore
        .collection('Chats')
        .where("userIds", arrayContains: userId)
        .snapshots()
        .map((snap) {
      return snap.docs
          .map((doc) => Chat.fromJson(
                doc.data(),
                id: doc.id,
              ))
          .toList();
    });
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

  @override
  Stream<List<LonerUser>> getUsers(LonerUser user) {
    return _firebaseFirestore
        .collection('LonerUser')
        // .where('gender', isEqualTo: 'Female')
        .where('server', isEqualTo: user.server)
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) => LonerUser.fromSnapshot(doc)).toList();
    });
  }

  @override
  Future<void> updateUserSwipes(
    String userId,
    String matchId,
    bool isSwipedRight,
  ) async {
    if (isSwipedRight) {
      await _firebaseFirestore.collection('LonerUser').doc(userId).update({
        'swipedRight': FieldValue.arrayUnion([matchId])
      });
    } else {
      await _firebaseFirestore.collection('LonerUser').doc(userId).update({
        'swipedLeft': FieldValue.arrayUnion([matchId])
      });
    }
  }

  @override
  Future<void> updateUserMatches(String userId, String matchId) async {
    //Create document inside Chats collection for storing messages.
    String chatId = await _firebaseFirestore.collection('Chats').add({
      'userIds': [userId, matchId],
      'messages': [],
    }).then((value) => value.id);
    //This will update the currently logged in user's matches.
    await _firebaseFirestore.collection('LonerUser').doc(userId).update({
      'matches': FieldValue.arrayUnion([
        {
          'matchId': matchId,
          'chatId': chatId,
        }
      ])
    });

    //This will update the other user's match on their end as well.
    await _firebaseFirestore.collection('LonerUser').doc(matchId).update({
      'matches': FieldValue.arrayUnion([
        {
          'matchId': userId,
          'chatId': chatId,
        }
      ])
    });
  }

  @override
  Stream<List<UserMatch>> getMatches(LonerUser user) {
    return Rx.combineLatest3(
      getUser(user.id!),
      getChats(user.id!),
      getUsers(user),
      (
        LonerUser user,
        List<Chat> userChats,
        List<LonerUser> otherUsers,
      ) {
        return otherUsers.where((otherUser) {
          List<String> matches =
              user.matches!.map((match) => match['matchId'] as String).toList();
          return matches.contains(otherUser.id);
        }).map((matchedUser) {
          Chat chat = userChats.where((chat) {
            return chat.userIds.contains(matchedUser.id) &
                chat.userIds.contains(user.id);
          }).first;

          return UserMatch(
              userId: user.id!, matchedUser: matchedUser, chat: chat);
        }).toList();
      },
    );
  }

  @override
  Stream<List<LonerUser>> getUsersToMatch(LonerUser user) {
    return Rx.combineLatest2(getUser(user.id!), getUsers(user), (
      LonerUser currentUser,
      List<LonerUser> users,
    ) {
      return users.where((user) {
        if (currentUser.swipedLeft!.contains(user.id)) {
          return false;
        } else if (currentUser.swipedRight!.contains(user.id)) {
          return false;
        } else if (currentUser.matches!.contains(user.id)) {
          return false;
        } else if (currentUser.id == user.id) {
          return false;
        } else {
          return true;
        }
      }).toList();
    });
  }
}
