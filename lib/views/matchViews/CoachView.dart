import 'package:flutter/material.dart';
import 'package:projectloner/views/NavBar.dart';
import '../home_view.dart';

class CoachPage extends StatefulWidget {
  
  const CoachPage({Key? key}) : super(key: key);

  @override
  CoachPageState createState() => CoachPageState();
}

class CoachPageState extends State {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Coaching Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Text( 
              'This feature is coming soon!',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Go Back"),
            )
          ]
        ),
      ),
      drawer: const NavBar(),
    );
  }
}