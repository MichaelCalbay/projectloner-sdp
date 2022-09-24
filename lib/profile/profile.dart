import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectloner/profile/profile_widget.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userfName = '';
  String userlName = '';

  Future _getDataFromDataBase() async {
    await FirebaseFirestore.instance
        .collection('LonerUser')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          userfName = snapshot.data()!["firstName"];
          userlName = snapshot.data()!["lastName"];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getDataFromDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: 'https://i.imgur.com/nnJZVxU.jpg',
              onClicked: () async {},
            ),
            const SizedBox(height: 24),
            buildName(),
          ],
        ));
  }

  Widget buildName() => Column(
        children: [
          Text(
            '$userfName $userlName',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            FirebaseAuth.instance.currentUser!.email!,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );
}
