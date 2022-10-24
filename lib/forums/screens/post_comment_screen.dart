// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/blocs/profile/profile_bloc.dart';
import 'package:projectloner/forums/screens/comment_list_screen.dart';
import 'package:projectloner/forums/utils.dart';
import 'package:projectloner/widgets/widgets.dart';
import '../widgets/forum_widgets.dart';

class PostCommentPage extends StatefulWidget {
  final DocumentSnapshot data;
  const PostCommentPage({
    super.key,
    required this.data,
  });

  @override
  State<PostCommentPage> createState() => _PostCommentPageState();
}

class _PostCommentPageState extends State<PostCommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Comments',
        actionButtons: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Forums')
            .doc(widget.data['postID'])
            .collection('Comments')
            .orderBy('commentTimeStamp', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LinearProgressIndicator();
          return BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ProfileLoaded) {
                return Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ListView(
                          children: [
                            Card(
                              elevation: 2.0,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(Icons.book, size: 34),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.data['postUserName'],
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Text(
                                                Utils.readTimestamp(widget
                                                    .data['postTimeStamp']),
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.indigo),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                        widget.data['postContent'],
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    widget.data['postImage'] != 'NONE' ? Utils.cacheNetworkImageWithEvent(context, widget.data['postImage'], 0,0)  :
                                    Container(),
                                    // const Divider(
                                    //   height: 5,
                                    //   color: Colors.grey,
                                    // ), // black lines going across
                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       top: 5.0, bottom: 5.0),
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceEvenly,
                                    //     children: [
                                    //       LikeButton(data: widget.data),
                                    //       CommentButton(data: widget.data),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            snapshot.data!.docs.isNotEmpty
                                ? Column(
                                    children: snapshot.data!.docs.map(
                                      (document) {
                                        return CommentList(data: document);
                                      },
                                    ).toList(),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    CommentComposer(
                      data: widget.data,
                      userName:
                          '${state.user.firstName} ${state.user.lastName}',
                    ),
                  ],
                );
              } else {
                const Center(
                  child: Text('Something went wrong...'),
                );
              }

              return Container();
            },
          );
        },
      ),
    );
  }
}
