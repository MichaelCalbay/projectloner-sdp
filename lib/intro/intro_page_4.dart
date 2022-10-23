// ignore: file_names
import 'package:flutter/material.dart';

class PageFour extends StatelessWidget {
  const PageFour({Key? key}) : super(key: key);

  /*======= MESSAGE PAGE ========*/

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/mail.png',
            width: 150,
            height: 250,
          ),
          //const SizedBox(height: 150),
          const Text(
            "Direct Messages\n",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.all(Radius.circular(150)),
            ),
            child: const Text(
              "\nTalk one-on-one with people on loner.\n"
                  "  Match with players that suite your interest     \n",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}