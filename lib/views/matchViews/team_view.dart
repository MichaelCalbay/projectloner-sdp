import 'package:flutter/material.dart';
import 'package:projectloner/views/nav_bar.dart';

import '../home_view.dart';

class TeamPage extends StatefulWidget {
  
  const TeamPage({Key? key}) : super(key: key);

  @override
  TeamPageState createState() => TeamPageState();
}

class TeamPageState extends State {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Team Matching")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text( 
            'Team matchmaking here',
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