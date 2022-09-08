import 'package:flutter/material.dart';
import 'NavBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'Home Page',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text("Duo"),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Team"),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Coach"),
              ),
            ],
          )
        ]),
      ),
      drawer: const NavBar(),
    );
  }
}
