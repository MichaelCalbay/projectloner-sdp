import 'package:flutter/material.dart';
import 'Page1.dart';
import 'HomeView.dart';

class Page2 extends StatefulWidget {
  Page2State createState() => Page2State();
}

class Page2State extends State {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Page 2")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text( 
            'Page 2',
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