import 'package:flutter/material.dart';
import 'package:projectloner/views/NavBar.dart';

class Page2 extends StatefulWidget {
  
  const Page2({Key? key}) : super(key: key);

  @override
  Page2State createState() => Page2State();
}

class Page2State extends State {
  
  @override
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
      drawer: const NavBar(),
    );
  }
}