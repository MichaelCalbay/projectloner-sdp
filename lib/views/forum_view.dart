import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectloner/forum/list_post.dart';
import 'package:projectloner/forum/posts_service.dart';
import 'package:provider/provider.dart';

import '../forum/posts_model.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);


  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  final PostService _postService = PostService();
  @override
  Widget build(BuildContext context) {
    return  StreamProvider<List<PostModel>>.value(
        value: _postService
            .getPostsByUser(FirebaseAuth
            .instance.currentUser?.uid),
      initialData: const [],
        child: Scaffold(
          body: Container(
            child: ListPosts(),
          ),
        )
    );
  }
}


