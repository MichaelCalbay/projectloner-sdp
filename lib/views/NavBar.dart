import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'HomeView.dart';
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
          const DrawerHeader(child: Text("Navigation Bar")),
          ListTile(
            title: const Text("Home Page"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          // ListTile(
          //   title: const Text("Page 1"),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(
          //         context, MaterialPageRoute(builder: (context) => Page1()));
          //   },
          // ),
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
