// ignore: file_names
import 'package:flutter/material.dart';

class PageFive extends StatelessWidget {
  const PageFive({Key? key}) : super(key: key);

  /*======= STATS PAGE ========*/

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red[500],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/glasses.png',
            width: 150,
            height: 250,
          ),
          //const SizedBox(height: 150),
          const Text(
            "Check Stats\n",
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
              "\n Stats are updated/shown of all players in our \n community"
                  "This include all game modes, KD and many more..."
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