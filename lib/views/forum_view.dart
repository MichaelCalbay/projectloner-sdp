import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectloner/forum/list_post.dart';
import 'package:projectloner/forum/posts_service.dart';
import 'package:provider/provider.dart';

import '../forum/add_post.dart';
import '../forum/posts_model.dart';
import '../widgets/matching_app_bar.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);


  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  final PostService _postService = PostService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PostModel>>.value(
        value: _postService
            .getPostsByUser(FirebaseAuth
            .instance.currentUser?.uid),
      initialData: const [],
        child: Scaffold(
          appBar: const MatchingAppBar(
            title: 'Forums',
            actionButtons: false,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
               //forum page view 'FOR NOW' -sam
               context, MaterialPageRoute(builder: (context) => Add()));
              },
            child: Icon(Icons.add),
          ),
          body: Container(
            child: ListPosts(),
          ),
        )
    );
  }
}


