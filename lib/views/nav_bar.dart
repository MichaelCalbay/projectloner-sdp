// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:instabug_flutter/instabug_flutter.dart';
import 'home_view.dart';
import 'package:projectloner/auth/auth_page.dart';
import 'package:projectloner/matching/matching_screen.dart';
import 'package:projectloner/profile/profile.dart';

//import 'HomeView.dart';
// import 'Page1.dart';
// import 'Page2.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(

              accountName: Text('Loner') // could be implented later on
              ,
              accountEmail:
                  Text('${FirebaseAuth.instance.currentUser!.email}')),

          ListTile(
            leading: Icon(Icons.person),
            title: Text('Matching'),
            onTap: () {
              //Close the Navigation drawer when back is tapped.
              Navigator.pop(context);

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MatchMaking(),
                ),
              );
            },
          ),
          ListTile(
            /*  BUG ICON  */
            leading: Icon(Icons.bug_report_rounded),
            title: Text('Reports'),
            onTap: () => Instabug.show(),
          ),
          ListTile(
            title: const Text("Home Page"),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),

          // ListTile(
          //   title: const Text("Page 2"),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(
          //         context, MaterialPageRoute(builder: (context) => Page2()));
          //   },
          // ),
          ListTile(
            title: const Text("Logout"),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            tileColor: Colors.deepPurple,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
