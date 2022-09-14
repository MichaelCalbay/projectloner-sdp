// ignore: file_names
import 'package:flutter/material.dart';

class PageFour extends StatelessWidget {
  const PageFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    color: Colors.pink[300],
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('images/her.png',
        width: 200,
        height: 300,
        ),
        //const SizedBox(height: 150), 
        const Text(
          "ONII-SAN\n",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),     
      ],   
    ),
    );
  }
}