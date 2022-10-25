import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/blocs/profile/profile_bloc.dart';
import 'package:projectloner/forums/Database/forums_firestore.dart';
import 'package:projectloner/forums/Database/local_DB.dart';
import 'package:projectloner/forums/Database/profile_data.dart';
import 'package:projectloner/forums/screens/post_comment_screen.dart';
import 'package:projectloner/forums/widgets/forum_widgets.dart';
import 'forums_data.dart';
import 'utils.dart';
import 'write_post.dart';
import '../widgets/custom_app_bar.dart';

class ForumsPage extends StatefulWidget {
  const ForumsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ForumsPage();
}

class _ForumsPage extends State<ForumsPage> {
  bool _isLoading = false;
  static String userName = '';

  @override
  void initState() {
    // _takeUserDataFromFireBase();
    super.initState();
  }

  Future<void> takeUserDataFromFireBase() async {
    setState(() {
      _isLoading = true;
    });
  }

  void _incrementCounter() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const WritePost()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          userName = '${state.user.firstName} ${state.user.lastName}';
        }
        return Scaffold(
          appBar: const CustomAppBar(
            title: 'Forums',
            actionButtons: false,
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Forums')
                .orderBy('postTimeStamp', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return const LinearProgressIndicator();
              return Stack(
                children: <Widget>[
                  snapshot.data!.docs.isNotEmpty
                      ? ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map(listTile).toList(),
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.error,
                                color: Colors.grey[700],
                                size: 64,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                  'There is no posts',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[700]),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                  _isLoading
                      ? Positioned(
                          child: Container(
                            // ignore: sort_child_properties_last
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            color: Colors.white.withOpacity(0.8),
                          ),
                        )
                      : Container()
                ],
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepPurple,
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(
              Icons.create,
              color: Colors.black,
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }

  void _moveToComment(DocumentSnapshot data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostCommentPage(
          data: data,
        ),
      ),
    );
  }

  void likePost(DocumentSnapshot data) async {
    if (!await ForumsStore.checkIfPostLiked(data['postID'], userName)) {
      _incrementPostLikeCount(data);
    } else {
      _decrementPostLikeCount(data);
    }
  }

  static Future<bool> _checkIfPostLiked(DocumentSnapshot data) async {
    return await ForumsStore.checkIfPostLiked(
      data['postID'],
      userName,
    );
  }

  void _incrementPostLikeCount(DocumentSnapshot data) async {
    await ForumsStore.incrementPostLikeCount(data);
    await ForumsStore.likeToPost(data['postID'], userName);
  }

  void _decrementPostLikeCount(DocumentSnapshot data) async {
    await ForumsStore.decrementPostLikeCount(data);
    await ForumsStore.unlikeToPost(
      data['postID'],
      userName,
    );
  }

  Widget listTile(DocumentSnapshot data) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () => _moveToComment(data),
                child: Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.book, size: 34),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data['postUserName'],
                          style: const TextStyle(fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            Utils.readTimestamp(data['postTimeStamp']),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.indigo),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //const Divider(height: 5, color: Colors.black,), // black lines going across
              GestureDetector(
                onTap: () => _moveToComment(data),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    data['postContent'],
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
              data['postImage'] != 'NONE'
                  ? Utils.cacheNetworkImageWithEvent(
                      context, data['postImage'], 0, 0)
                  : Container(),
              //const Divider(height: 5, color: Colors.black,), // black lines going across
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => likePost(data),
                        child: LikeButton(
                          data: data,
                          isPostLiked: _checkIfPostLiked(data),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _moveToComment(data),
                        child: CommentButton(data: data),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
