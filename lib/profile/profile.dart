import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectloner/models/models.dart';
import 'package:projectloner/models/user_model.dart';
import '../views/NavBar.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? fName = '';

  String? lName = '';

  String? email = '';

  String? age = '';

  String? gender = '';

  String? role = '';

  String? server = '';

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection("LonerUser")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          age = snapshot.data()!["Age"];
          email = snapshot.data()!["Email"];
          fName = snapshot.data()!["Firstname"];
          gender = snapshot.data()!["Gender"];
          lName = snapshot.data()!["Lastname"];
          role = snapshot.data()!["Roles"];
          server = snapshot.data()!["Server"];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cUser = LonerUser.users[1];

    return Scaffold(
      appBar: buildAppBar(),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: cUser.imageUrls[0],
            onClicked: () async {},
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
      drawer: const NavBar(),
    );
  }

  Widget buildName(State conext) => Column(
        children: [Text('${fName}')],
      );
}
