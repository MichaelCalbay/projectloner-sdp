// ignore: file_names
import 'package:flutter/material.dart';
import 'package:projectloner/views/matchViews/coach_view.dart';
import 'package:projectloner/views/matchViews/duo_view.dart';
import 'package:projectloner/views/matchViews/team_view.dart';
import '../matching/matching_screen.dart';
import 'nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State {

  String preferenceText = "Currently looking for duo";
  String matchButtonText = "Start";
  final List<bool> _matchPreferences = <bool>[true, false, false];

  void startMatching(List<bool> matchPreferences) {
    if (matchPreferences[0] == true) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MatchMaking(),
        ),
      );
    }
    else if (matchPreferences[1] == true) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => TeamPage()));
    }
    else if (matchPreferences[2] == true) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => CoachPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('images/gamepad.png',
              width: 100,
              height: 150,
            ),
            const Text( 
              'Hello *User*!',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 275, 
              child: Text( 
                'Find your ideal duo or team to play with! Who knows? It could be the start of your love story!',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),              
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Choose your preference",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                ToggleButtons(
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < _matchPreferences.length; i++) {
                        _matchPreferences[i] = i == index;
                      }
                    });
                  },
                  isSelected: _matchPreferences,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: Colors.deepPurple,
                  selectedColor: Colors.white,
                  fillColor: Colors.deepPurple,
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  children: const [
                    Text("Duo"),
                    Text("Team"),
                    Text("Coach"),             
                  ],
                ),
              ],
            ),           
            ElevatedButton(
              onPressed: () {
                startMatching(_matchPreferences);
              }, 
              child: Text(matchButtonText))
          ]
        ),
      ),
      drawer: const NavBar(),
    );
  }
}
