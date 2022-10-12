import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../forums/forums_data.dart';
import '../forums/utils.dart';
import '../forums/write_post.dart';
import '../widgets/matching_app_bar.dart';

class ForumsPage extends StatefulWidget{
  const ForumsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ForumsPage();

}

class _ForumsPage extends State<ForumsPage>{

  bool _isLoading = false;

  @override
  void initState() {
    // _takeUserDataFromFireBase();
    super.initState();
  }

  Future<void> _takeUserDataFromFireBase() async{

    setState(() {
      _isLoading = true;
    });

  }
  void _incrementCounter() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WritePost()
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MatchingAppBar(
        title: 'Forums',
        actionButtons: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Forums').orderBy('postTimeStamp', descending: true).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData) return LinearProgressIndicator();
            return Stack(
              children: <Widget>[
                snapshot.data!.docs.length > 0 ?
                ListView(
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map(listTile).toList(),
                ) : Container(
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.error, color: Colors.grey[700],
                            size: 64,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text('There is no posts',
                              style: TextStyle(fontSize: 16,color: Colors.grey[700]),
                              textAlign: TextAlign.center,),
                          ),
                        ],
                      )
                  ),
                ),
                _isLoading ? Positioned(
                  child: Container(
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    color: Colors.white.withOpacity(0.8),
                  ),
                ) : Container()
              ],
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.create),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget listTile(DocumentSnapshot data){
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
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
                      Text(data['userName'],style: const TextStyle(fontSize: 20),),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(readTimestamp(data['postTimeStamp']),style: const TextStyle(fontSize: 15, color: Colors.indigo),),
                      ),
                    ],
                  ),
                ],
              ),
              //const Divider(height: 5, color: Colors.black,), // black lines going across
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(data['postContent'],style: const TextStyle(fontSize: 15),),
              ),
              //const Divider(height: 5, color: Colors.black,), // black lines going across
              Padding(
                padding: const EdgeInsets.only(top:5.0, bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget> [
                    Row(
                      children: <Widget>[
                        Icon(Icons.thumb_up),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('Like(${data['postLikeCounter']})', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget> [
                        Icon(Icons.mode_comment),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('Comment(${data['postCommentCounter']})', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // SizedBox( //size of posts
              //  height: 10,
              // )
            ],
          ),
        ),
      ),

    );
  }

}

