import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel{

  late final String id;
  late final String user;
  late final String text;
  late final Timestamp timestamp;

  PostModel({required this.id, required this.user, required this.text, required this.timestamp});
}