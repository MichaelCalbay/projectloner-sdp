import 'package:flutter/material.dart';
import 'package:projectloner/views/HomeView.dart';
import 'package:projectloner/views/NavBar.dart';
import 'package:projectloner/views/matchViews/TeamView.dart';

class DuoPage extends StatefulWidget {
  
  const DuoPage({Key? key}) : super(key: key);

  @override
  DuoPageState createState() => DuoPageState();
}

class DuoPageState extends State {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Duo Matching")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text( 
              'Duo matchmaking here',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text("Go Back"),
            ),
          ]
        ),
      ),
      drawer: const NavBar(),
    );
  }
}