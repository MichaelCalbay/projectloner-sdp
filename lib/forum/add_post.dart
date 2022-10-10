import 'package:flutter/material.dart';
import 'package:projectloner/forum/posts_service.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final PostService _postService = PostService();
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formus'),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
             onPressed: () async{
               _postService.savePost(text);
               Navigator.pop(context);
             },

             child: Text('Post'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: new Form(
            child: TextFormField(
              onChanged: (val) {
                setState(() {
                  text = val;
                });
              },
            )
        ),
      ),
    );
  }
}

