import 'package:flutter/material.dart';
import 'package:projectloner/views/matchViews/CoachView.dart';
import 'package:projectloner/views/matchViews/DuoView.dart';
import 'package:projectloner/views/matchViews/TeamView.dart';
import 'NavBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State {

  String preferenceText = "Currently looking for duo";
  String matchButtonText = "Start";
  final List<bool> _matchPreferences = <bool>[true, false, false];


  void updatePage() {
    
  }

  void startMatching(List<bool> matchPreferences) {
    if (matchPreferences[0] == true) {
      print("Duo");
      Navigator.push(context, MaterialPageRoute(builder: (context) => DuoPage()));
    }
    else if (matchPreferences[1] == true) {
      print("Team");
      Navigator.push(context, MaterialPageRoute(builder: (context) => TeamPage()));
    }
    else if (matchPreferences[2] == true) {
      print("Coach");
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
            const Text( 
            'Home Page',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            // I am stoopid
            /*
            ButtonBar(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: duo ? null : () {
                    changePreference("duo");
                  }, 
                  child: const Text("Duo"),
                ),
                ElevatedButton(
                  onPressed: team ? null : () {
                    changePreference("team");
                  }, 
                  child: const Text("Team"),
                ),
                ElevatedButton(
                  onPressed: coach ? null : () {
                    changePreference("coach");
                  }, 
                  child: const Text("Coach"),
                ),
              ],
            ),*/
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
              ]),
            //Text(preferenceText),
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
