import 'package:flutter/material.dart';
import 'package:projectloner/views/nav_bar.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Page1State createState() => Page1State();
}

class Page1State extends State {
  @override
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
            ]),
      ),
      drawer: const NavBar(),
    );
  }
}
