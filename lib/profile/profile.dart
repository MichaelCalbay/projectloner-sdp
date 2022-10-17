<<<<<<< Updated upstream
import 'dart:convert';
=======
import 'dart:async';
import 'dart:convert';
import 'dart:core';
>>>>>>> Stashed changes
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:projectloner/profile/profile_widget.dart';
import 'package:http/http.dart' as http;
=======
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../widgets/profile_widget.dart';
import 'package:projectloner/stats/user_stats.dart';
>>>>>>> Stashed changes

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userfName = '';
  String userlName = '';
<<<<<<< Updated upstream

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
=======
  int? elo = 0;

  Future getDataFromDataBase() async {
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

  Future getStats() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.henrikdev.xyz/valorant/v1/mmr/ap/nismistrigis/oce"));
    if (response.statusCode == 200) {
      setState(() {});
      UserStats userStats = UserStats.fromJson(jsonDecode(response.body));
      elo = userStats.data!.elo;
    }
>>>>>>> Stashed changes
  }

  @override
  void initState() {
    super.initState();
<<<<<<< Updated upstream
    _getDataFromDataBase();
=======
    getDataFromDataBase();
    getStats();
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
          )
=======
          ),
          Text(elo.toString()),
>>>>>>> Stashed changes
        ],
      );
}
