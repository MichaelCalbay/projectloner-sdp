import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectloner/forums/utils.dart';
import 'package:projectloner/widgets/widgets.dart';
import '../widgets/forum_widgets.dart';

class CommentPage extends StatelessWidget {
  final DocumentSnapshot data;
  const CommentPage({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Comments',
        actionButtons: false,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  Card(
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.book, size: 34),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    data['userName'],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      readTimestamp(data['postTimeStamp']),
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.indigo),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //const Divider(height: 5, color: Colors.black,), // black lines going across
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              data['postContent'],
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          //const Divider(height: 5, color: Colors.black,), // black lines going across
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 5.0, bottom: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                LikeButton(data: data),
                                CommentButton(data: data),
                              ],
                            ),
                          ),
                          CommentComposer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
