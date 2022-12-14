// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/blocs/profile/profile_bloc.dart';
import 'package:projectloner/forums/Database/comments_firestore.dart';
import 'package:projectloner/forums/utils.dart';
import '../../theme/theme_provider.dart';

class CommentList extends StatefulWidget {
  final DocumentSnapshot data;
  const CommentList({
    super.key,
    required this.data,
  });

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  final themeProvider = LonerThemeProvider();

  static String userName = '';

  void likeComment(DocumentSnapshot data) async {
    if (!await CommentStore.checkIfLiked(
        data['postID'], data['commentID'], userName)) {
      _incrementCommentLikeCount(data);
    } else {
      _decrementCommentLikeCount(data);
    }
  }

  static Future<bool> _checkIfLiked(DocumentSnapshot data) async {
    return await CommentStore.checkIfLiked(
        data['postID'], data['commentID'], userName);
  }

  void _incrementCommentLikeCount(DocumentSnapshot data) async {
    await CommentStore.incrementCommentLikeCount(data);
    await CommentStore.likeToComment(
        data['postID'], data['commentID'], userName);
  }

  void _decrementCommentLikeCount(DocumentSnapshot data) async {
    await CommentStore.decrementCommentLikeCount(data);
    await CommentStore.unlikeToComment(
        data['postID'], data['commentID'], userName);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProfileLoaded) {
          userName = '${state.user.firstName} ${state.user.lastName}';
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(6.0, 2.0, 10.0, 2.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(widget.data.exists
                        ? widget.data['commentUserThumbnail']
                        : 'https://thumbs.dreamstime.com/b/no-user-profile-picture-hand-drawn-illustration-53840792.jpg'),
                    backgroundColor: Colors.black87,
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: themeProvider.isDarkMode
                                  ? Colors.grey[850]
                                  : Colors.grey[300],
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      widget.data['commentUserName'],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(widget.data['commentContent']),
                                  ),
                                  SizedBox(height: 12),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 12,
                            child: Card(
                              elevation: 2.0,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.thumb_up,
                                    size: 14,
                                    color: Colors.deepPurple,
                                  ),
                                  Text(
                                    '${widget.data['commentLikeCount']}',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                        child: SizedBox(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                Utils.readTimestamp(
                                    widget.data['commentTimeStamp']),
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.deepPurple),
                              ),
                              GestureDetector(
                                onTap: () => likeComment(widget.data),
                                child: FutureBuilder<bool>(
                                  future: _checkIfLiked(widget.data),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<bool> snapshot) {
                                    if (snapshot.data == false) {
                                      return Text('Like',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: themeProvider.isDarkMode
                                                ? Colors.grey[300]
                                                : Colors.grey[700],
                                          ));
                                    } else {
                                      return Text(
                                        'Unlike',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: themeProvider.isDarkMode
                                              ? Colors.grey[300]
                                              : Colors.grey[700],
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
          );
        } else {
          const Center(
            child: Text('Something went wrong...'),
          );
        }

        return Container();
      },
    );
  }
}
