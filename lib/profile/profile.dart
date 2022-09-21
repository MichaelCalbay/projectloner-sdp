import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectloner/profile/profile_widget.dart';
import 'appbar_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String age = '';
  String email = '';
  String firstName = '';
  String gender = '';
  String lastName = '';
  String role = '';
  String server = '';
  String imagePath = 'https://i.imgur.com/nnJZVxU.jpg';

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
          firstName = snapshot.data()!["First Name"];
          gender = snapshot.data()!["Gender"];
          lastName = snapshot.data()!["Last Name"];
          role = snapshot.data()!["Roles"];
          server = snapshot.data()!["Server"];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(),
        ],
      ),
    );
  }

  Widget buildName() => Column(
        children: [
          Text(firstName),
        ],
      );
}
