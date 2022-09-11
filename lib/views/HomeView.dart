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
  String matchButtonText = "Match for Duo!";
  bool duo = true;
  bool team = false;
  bool coach = false;

  void changePreference(String preference) {
    
    switch(preference) {
      case "duo":
        // Duo Matching
        duo = true;
        team = false;
        coach = false;
        break;
      case "team":
        // Team Matching
        duo = false;
        team = true;
        coach = false;
        break;
      case "coach":
        // Coach
        duo = false;
        team = false;
        coach = true;
        break;
    }
    if (coach == true) {
      setState(() {
        preferenceText = "Currently a coach";
        matchButtonText = "Start coaching!";
      });  
    } 
    else {
      setState(() {
        preferenceText = "Currently looking for $preference";
        matchButtonText = "Find your $preference!";
      });
    }  
  }

  void startMatching() {
    if (duo) {
      print("Duo");
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => DuoPage()));
    }
    else if (team) {
      print("Team");
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => TeamPage()));
    }
    else if (coach) {
      print("Coach");
      Navigator.pop(context);
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
            ),
            Text(preferenceText),
            ElevatedButton(
              onPressed: () {
                startMatching();
              }, 
              child: Text(matchButtonText))
          ]
        ),
      ),
      drawer: const NavBar(),
    );
  }
}