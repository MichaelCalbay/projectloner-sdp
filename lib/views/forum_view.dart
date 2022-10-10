import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectloner/forum/list_post.dart';
import 'package:projectloner/forum/posts_service.dart';
import 'package:provider/provider.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);


  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  PostService _postService = PostService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value:
        _postService.getPostsByUser(FirebaseAuth.instance.currentUser?.uid),
      initialData: [],
      child: Scaffold(
        body: Container(
          child: const ListPosts(),
        ),
      )
    );





  }
}


