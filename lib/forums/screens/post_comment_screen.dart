// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectloner/forums/screens/comment_list_screen.dart';
import 'package:projectloner/forums/utils.dart';
import 'package:projectloner/widgets/widgets.dart';
import '../widgets/forum_widgets.dart';

class CommentPage extends StatefulWidget {
  final DocumentSnapshot data;
  const CommentPage({
    super.key,
    required this.data,
  });

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
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
            .collection('Comment')
            .orderBy('commentTimeStamp', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LinearProgressIndicator();
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
                                        widget.data['userName'],
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          readTimestamp(
                                              widget.data['postTimeStamp']),
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
                              const Divider(
                                height: 5,
                                color: Colors.grey,
                              ), // black lines going across
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    LikeButton(data: widget.data),
                                    CommentButton(data: widget.data),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      snapshot.data!.docs.isNotEmpty
                          ? ListView(
                              shrinkWrap: true,
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
              CommentComposer(data: widget.data),
            ],
          );
        },
      ),
    );
  }
}
