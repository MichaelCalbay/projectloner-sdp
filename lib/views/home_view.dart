// ignore: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../matching/matching_screen.dart';
import '../theme/theme_provider.dart';
import 'forum_view.dart';
import '../forums/forums_view.dart';
import 'nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State {
  @override
  Widget build(BuildContext context) {
    LonerThemeProvider themeProvider = LonerThemeProvider();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        backgroundColor: Colors.deepPurple,
      ),
      // body: Scrollbar(
      //   child: DecoratedBox(
      //     decoration: const BoxDecoration(
      //       // This area was for background image but I decided to leave it out for now
      //       // cause quality is kinda wierd.
      //       // - Ben
      //       /*
      //       image: DecorationImage(
      //         image: AssetImage("images/valo_bg.png"),
      //         fit: BoxFit.cover,
      //       ),*/
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 60),
                    Image.asset(
                      'images/gamepad.png',
                      width: 100,
                      height: 150,
                    ),
                    const SizedBox(height: 60),
                    const Text(
                      'Hello *User*!',
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 275,
                      child: Text(
                        'Find your ideal duo or team to play with! Who knows? It could be the start of your love story!',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                        width: 300,
                        child: Column(
                          children: const [
                            Text(
                              "About Loner",
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Loner provides a platform for valorant players to able to find"
                              " their ideal teammate(s) to play with, whether it would be players"
                              " that have really good statistics in their profile or players that they"
                              " have similar interests with.",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 25),
                            Text(
                              "Here through our match making system, you'll be able to find an online friend"
                              " that you could banter with or you could possibly find the love of your life"
                              " should you wish. All this you can do while tapping heads, left, right and center"
                              " with your friend/soulmate/love interest",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                    const SizedBox(height: 50),
                    SizedBox(
                        width: 300,
                        child: Column(
                          children: const [
                            Text(
                              "Current Features",
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "- Duo Match Making",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "- Valorant Stats",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "- Direct Messaging",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "- Forum Posting",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        )),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const NavBar(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (int newIndex) {
          switch (newIndex) {
            case 0:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MatchMaking(),
              ));
              break;
            case 1:
              Navigator.push(
                  //forum page view 'FOR NOW' -sam
                  context,
                  MaterialPageRoute(builder: (context) => const ForumsPage()));
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(label: "Duo", icon: Icon(Icons.person)),
          BottomNavigationBarItem(label: "Forums", icon: Icon(Icons.forum)),
        ],
      ),
    );
  }
}
