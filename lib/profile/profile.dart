import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../widgets/profile_widget.dart';
import 'package:projectloner/stats/user_stats.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userfName = '';
  String userlName = '';
  int? elo = 0;
  String? rank = '';
  String ign = 'nismistrigis';
  String tag = 'oce';
  String server = 'ap';

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

  Future getStats(String tag, String ign, String server) async {
    http.Response response = await http.get(Uri.parse(
        "https://api.henrikdev.xyz/valorant/v1/mmr/$server/$ign/$tag"));
    if (response.statusCode == 200) {
      setState(() {});
      UserStats userStats = UserStats.fromJson(jsonDecode(response.body));
      elo = userStats.data!.elo;
      rank = userStats.data!.currenttierpatched;
    }
  }

  @override
  void initState() {
    super.initState();
    getDataFromDataBase();
    getStats(server, ign, tag);
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
          ),
          Text(elo.toString() + rank!),
        ],
      );
}
