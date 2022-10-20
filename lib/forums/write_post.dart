// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:projectloner/blocs/profile/profile_bloc.dart';

class WritePost extends StatefulWidget {
  const WritePost({
    Key? key,
  }) : super(key: key);

  @override
  State<WritePost> createState() => _WritePostState();
}

class _WritePostState extends State<WritePost> {
  final FocusNode _nodeText1 = FocusNode();
  FocusNode writingTextFocus = FocusNode();
  TextEditingController writingTextController = TextEditingController();
  bool _isLoading = false;

  KeyboardActionsConfig buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: Colors.grey[200],
        nextFocus: true,
        actions: [
          KeyboardActionsItem(
            displayArrows: false,
            focusNode: _nodeText1,
          ),
          KeyboardActionsItem(
            displayArrows: false,
            focusNode: writingTextFocus,
            toolbarButtons: [
              (node) {
                return GestureDetector(
                  onTap: () {
                    print('Close view');
                    Navigator.pop(context);
                    node.unfocus();
                  },
                  child: Container(
                    color: Colors.grey[200],
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      "Image",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
              //     (node){
              //   return GestureDetector(
              //     onTap: (){
              //       // print('Close view');
              //       // Navigator.pop(context);
              //       // node.unfocus();
              //     },
              //     // child: Container(
              //     //   color: Colors.grey[200],
              //     //   padding: EdgeInsets.all(8.0),
              //     //   child: Text(
              //     //     "Done",
              //     //     style: TextStyle(
              //     //         color: Colors.black,
              //     //         fontSize: 18,
              //     //         fontWeight: FontWeight.bold),
              //     //   ),
              //     // ),
              //   );
              // },
            ],
          ),
        ]);
  }

  Future<void> sentPostInFireBase(
      String postContent, String postID, String userName) async {
    setState(() {
      _isLoading = true;
    });

    FirebaseFirestore.instance.collection('Forums').doc(postID).set({
      'postID': postID,
      'postUserName': userName,
      'postUserThumbnail': '',
      'postTimeStamp': DateTime.now().millisecondsSinceEpoch,
      'postContent': postContent,
      'postImage': 'testUserName',
      'postLikeCounter': 0,
      'postCommentCounter': 0
    });
    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    String fID = FirebaseFirestore.instance.collection('Forums').doc().id;
    final size = MediaQuery.of(context).size;

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProfileLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Writing Post'),
              centerTitle: true,
              actions: <Widget>[
                TextButton(
                  onPressed: () => sentPostInFireBase(
                      writingTextController.text,
                      fID,
                      '${state.user.firstName} ${state.user.lastName}'),
                  child: const Text(
                    'post',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            body: KeyboardActions(
              config: buildConfig(context),
              child: Stack(
                children: [
                  Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Card(
                          color: Colors.white,
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Container(
                            width: size.width,
                            height: size.height -
                                MediaQuery.of(context).viewInsets.bottom -
                                80,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 14.0, left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.book,
                                          size: 20,
                                        ),
                                      ),
                                      Text(
                                        '${state.user.firstName} ${state.user.lastName}',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  const Divider(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                  TextFormField(
                                    autofocus: true,
                                    focusNode: writingTextFocus,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Start writing...',
                                      hintMaxLines: 4,
                                    ),
                                    controller: writingTextController,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  _isLoading
                      ? Positioned(
                          child: Container(
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            color: Colors.white.withOpacity(0.8),
                          ),
                        )
                      : Container()
                ],
              ),
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
