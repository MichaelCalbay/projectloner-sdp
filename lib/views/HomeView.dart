import 'package:flutter/material.dart';
import 'Page1.dart';
import 'Page2.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text( 
            'Home Page',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            ButtonBar(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {

                  }, 
                  child: Text("Duo"),
                ),
                ElevatedButton(
                  onPressed: () {

                  }, 
                  child: Text("Team"),
                ),
                ElevatedButton(
                  onPressed: () {

                  }, 
                  child: Text("Coach"),
                ),
              ],
            )
          ]
        ),
      ),
      drawer: Drawer(
        width: 200,
        child: ListView(
          children: [
            const DrawerHeader(child: Text("Navigation Bar")),
            ListTile(
              title: const Text("Home Page"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              title: const Text("Page 1"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Page1()));
              },
            ),
            ListTile(
              title: const Text("Page 2"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Page2()));
              },
            ),
            ListTile(
              title: const Text("Logout"),
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}