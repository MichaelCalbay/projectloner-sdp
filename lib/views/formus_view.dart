import 'package:flutter/material.dart';
import 'package:projectloner/views/nav_bar.dart';

class ForumsPage extends StatefulWidget {
  const ForumsPage({Key? key}) : super(key: key);

  @override
  ForumsPageState createState() => ForumsPageState();
}

class ForumsPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Formus")),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'Formus Page',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Go Back"),
          ),
        ]),
      ),
      drawer: const NavBar(),
    );
  }
}
