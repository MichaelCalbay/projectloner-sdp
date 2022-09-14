// ignore: file_names
import 'package:flutter/material.dart';

class PageThree extends StatelessWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    color: Colors.yellow[300],
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('images/mail.png',
        width: 200,
        height: 300,
        ),
        //const SizedBox(height: 150), 
        const Text(
          "Direct Messages\n",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "Talk one-on-one with people on loner.\n"
          "Message coaches or players that suite your interest\n",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
      ],   
    ),
    );
  }
}