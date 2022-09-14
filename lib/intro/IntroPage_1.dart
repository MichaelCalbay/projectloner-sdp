// ignore: file_names
import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    color: Colors.purple[200],
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('images/gamer.png',
        width: 200,
        height: 300,
        ),
        //const SizedBox(height: 150), 
        const Text(
          "Welcome to Loner!\n",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "Find your next gamer\n",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 137, 243, 220),
          ),
        ),
      ],   
    ),
    );
  }
}