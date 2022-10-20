// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/blocs/profile/profile_bloc.dart';
import 'package:projectloner/forums/utils.dart';

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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProfileLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(6.0, 2.0, 10.0, 2.0),
                  child: Icon(Icons.book, size: 34),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
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
                                    '0',
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
                          width: 130,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                readTimestamp(widget.data['commentTimeStamp']),
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.deepPurple),
                              ),
                              Text(
                                'Like',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                'Reply',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
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
