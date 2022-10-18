import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'dart:io';

class WritePost extends StatefulWidget {
  const WritePost({Key? key}) : super(key: key);

  @override
  State<WritePost> createState() => _WritePostState();
}

class _WritePostState extends State<WritePost> {
  final FocusNode _nodeText1 = FocusNode();
  FocusNode writingTextFocus = FocusNode();
  TextEditingController writingTextController = TextEditingController();
  bool _isLoading = false;
  XFile? postImageFIle;

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
                    getImage();
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

  Future<void> sentPostInFireBase(String postContent) async {
    setState(() {
      _isLoading = true;
    });

    FirebaseFirestore.instance.collection('Forums').doc().set({
      'userName': 'Sam',
      'userThumbnail': '',
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
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Writing Post'),
          centerTitle: true,
          actions: <Widget>[
            TextButton(
              onPressed: () => sentPostInFireBase(writingTextController.text),
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
                          padding:
                              const EdgeInsets.only(right: 14.0, left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.book,
                                      size: 20,
                                    ),
                                  ),
                                  Text(
                                    'Sam',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),

                              Divider(height:1, color: Colors.black,),
                              postImageFIle != null ? Image.file(File(postImageFIle!.path)) :
                                  Container(),
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
                        color: Colors.white.withOpacity(0.8),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ));
  }

  Future<void> getImage() async{
    XFile? imageFileFromGAllery = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(imageFileFromGAllery != null){
      setState(() {
        postImageFIle = imageFileFromGAllery;
      });
    }
  }
}
