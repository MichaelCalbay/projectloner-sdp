// ignore: file_names
import 'package:flutter/material.dart';

class PageSix extends StatelessWidget {
  const PageSix({Key? key}) : super(key: key);

  /*======= STATS PAGE ========*/

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[500],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/forums.png',
            width: 150,
            height: 250,
          ),
          //const SizedBox(height: 150),
          const Text(
            "Forums\n",
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
              "\nOnline discussion board where people can "
                  "ask questions, share their "
                  "experiences, and "
                  "\ndiscuss topics of mutual interest"
                  "\n",
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