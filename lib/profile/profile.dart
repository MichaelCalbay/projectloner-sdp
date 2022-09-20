import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectloner/models/models.dart';
import 'package:projectloner/models/user_model.dart';

import '../views/nav_bar.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/profile_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cUser = LonerUser.users[1];

    return Scaffold(
      appBar: buildAppBar(),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          // ProfileWidget(
          //   imagePath: cUser.imageUrls[0],
          //   onClicked: () async {},
          // ),
          const SizedBox(
            height: 24,
          ),
          buildName(LonerUser.users[1]),
        ],
      ),
      drawer: const NavBar(),
    );
  }

  Widget buildName(LonerUser cUser) => Column(children: [
        Text("${FirebaseAuth.instance.currentUser!.displayName}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        Text("${FirebaseAuth.instance.currentUser!.email}"),
      ]);
}
