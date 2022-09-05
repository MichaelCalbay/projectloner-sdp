import 'package:flutter/material.dart';
import 'HomeView.dart';
import 'Page2.dart';

class Page1 extends StatefulWidget {
  Page1State createState() => Page1State();
}

class Page1State extends State {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page 1")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text( 
            'Page 1',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
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