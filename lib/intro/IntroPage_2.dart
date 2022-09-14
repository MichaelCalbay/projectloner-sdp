// ignore: file_names
import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    color: Colors.blue[200],
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('images/bug.png',
        width: 200,
        height: 300,
        ),
        //const SizedBox(height: 150), 
        const Text(
          "Create new issues\n",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "Thankyou for helping us improve our app.\n"
          "Give feedback on any bug reports\n"
          "whether the issue is small or big.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ],   
    ),
    );
  }
}