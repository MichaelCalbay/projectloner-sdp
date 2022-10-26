import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:projectloner/stats/user_stats.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List ranks = ['No Rank This Season'];
  List rankUrls = [
    'https://media.tenor.com/wpSo-8CrXqUAAAAi/loading-loading-forever.gif'
  ];
  List winPercentages = [' '];
  List killDeathRatios = [' '];
  List scorePerRounds = [' '];
  List headShots = [' '];

  late DocumentReference docRef;

  String imageAsset = 'projectloner-sdp/images/noRank.png';
  String firstName = '';
  String lastName = '';
  String name = '';
  String tag = '';
  String profilePicture =
      'https://media.tenor.com/wpSo-8CrXqUAAAAi/loading-loading-forever.gif';
  String bio = '(Empty)';
  String age = '';

  @override
  void initState() {
    getFireBaseInfo()
        .whenComplete(getRank)
        .whenComplete(getImageUrl)
        .whenComplete(getWinPercentage)
        .whenComplete(getKillDeathRatio)
        .whenComplete(getScorePerRound)
        .whenComplete(getHeadshotPercentage);

    super.initState();
  }

  Future getFireBaseInfo() async {
    await FirebaseFirestore.instance
        .collection('LonerUser')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!["ign"];
          tag = snapshot.data()!["tag"];
          firstName = snapshot.data()!["firstName"];
          lastName = snapshot.data()!["lastName"];
          List profilePics = snapshot.get('imageUrls');
          profilePicture = profilePics[0];
          bio = snapshot.data()!["bio"];
          age = snapshot.data()!["age"];
        });
      }
    });
  }

  Future getRank() async {
    final url = Uri.parse(
        'https://tracker.gg/valorant/profile/riot/$name%23$tag/overview');
    final response = await http.get(url);

    dom.Document html = dom.Document.html(response.body);

    final rank = html
        .querySelectorAll('span.stat__value')
        .map((element) => element.innerHtml.trim())
        .toList();
    setState(() {
      if (rank.isEmpty) {
        ranks[0] = 'No Rank This Season';
      } else {
        ranks = rank;
      }
    });
  }

  Future getImageUrl() async {
    final url = Uri.parse(
        'https://tracker.gg/valorant/profile/riot/$name%23$tag/overview');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final rankUrl = html
        .querySelectorAll(
            '#app > div.trn-wrapper > div.trn-container > div > main > div.content.no-card-margin > div.site-container.trn-grid.trn-grid--vertical.trn-grid--small > div.trn-grid.container > div.area-main > div.segment-stats.area-main-stats.card.bordered.header-bordered.responsive > div.highlighted.highlighted--giants > div.highlighted__content > div > div.trn-profile-highlighted-content__stats > img')

        .map((element) => element.attributes['src'])
        .toList();

    setState(() {
      rankUrls = rankUrl;
    });
  }

  Future getWinPercentage() async {
    final url = Uri.parse(
        'https://tracker.gg/valorant/profile/riot/$name%23$tag/overview');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);
    final winPercentage = html
        .querySelectorAll('div:nth-child(3) > div > div.numbers > span.value')
        .map((element) => element.innerHtml)
        .toList();
    setState(() {
      winPercentages = winPercentage;

      FirebaseFirestore.instance
          .collection('LonerUser')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'winPercentage': winPercentages[0]});
    });
  }

  Future getScorePerRound() async {
    final url = Uri.parse(
        'https://tracker.gg/valorant/profile/riot/$name%23$tag/overview');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final scorePerRound = html
        .querySelectorAll('div:nth-child(4) > div > div.numbers > span.value')
        .map((e) => e.innerHtml.trim())
        .toList();

    setState(() {
      scorePerRounds = scorePerRound;

      FirebaseFirestore.instance
          .collection('LonerUser')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'scorePerRound': scorePerRounds[0]});
    });
  }

  Future getKillDeathRatio() async {
    final url = Uri.parse(
        'https://tracker.gg/valorant/profile/riot/$name%23$tag/overview');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final killDeathRadio = html
        .querySelectorAll(
            'div.giant-stats > div:nth-child(1) > div > div.numbers > span.value')
        .map((e) => e.innerHtml.trim())
        .toList();

    setState(() {
      killDeathRatios = killDeathRadio;

      FirebaseFirestore.instance
          .collection('LonerUser')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'kdRatio': killDeathRatios[0]});
    });
  }

  Future getHeadshotPercentage() async {
    final url = Uri.parse(
        'https://tracker.gg/valorant/profile/riot/$name%23$tag/overview');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final headshotPercentage = html
        .querySelectorAll(
            'div.giant-stats > div:nth-child(2) > div > div.numbers > span.value')
        .map((e) => e.innerHtml.trim())
        .toList();

    setState(() {
      headShots = headshotPercentage;
      FirebaseFirestore.instance
          .collection('LonerUser')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'headshotPercentage': headshotPercentage[0]});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          centerTitle: true,
          title: const Text('Profile'),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.edit))],
        ),
        body: ListView(padding: EdgeInsets.zero, children: [
          const SizedBox(height: 11),
          SizedBox(
            height: 128,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              maxRadius: 128,
              minRadius: 128,
              child: ClipOval(child: Image.network(profilePicture)),
            ),
          ),
          Text(
            '$firstName' ' ' '$lastName' ',' ' ' '$age',
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Column(children: [
            Text(
              '(' '$name' ')',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              ranks.isEmpty ? 'Loading...' : ranks[0],
              textAlign: TextAlign.center,
            ),
            CircleAvatar(
              maxRadius: 24,
              minRadius: 24,
              backgroundColor: Colors.transparent,
              child: Image.network(
                rankUrls.isEmpty ? 'No Rank' : rankUrls[0],
              ),
            ),
          ]),
          Row(children: [
            SizedBox(
              width: 6,
            ),
            Column(children: [
              Text("Win Percentage"),
              Text(winPercentages.isEmpty ? 'Loading...' : winPercentages[0]),
            ]),
            SizedBox(
              width: 27,
            ),
            Column(
              children: [
                Text("K/D Ratio"),
                Text(killDeathRatios.isEmpty
                    ? 'Loading...'
                    : killDeathRatios[0]),
              ],
            ),
            SizedBox(
              width: 27,
            ),
            Column(
              children: [
                Text("Score/Round"),
                Text(scorePerRounds.isEmpty ? 'Loading...' : scorePerRounds[0]),
              ],
            ),
            SizedBox(
              width: 27,
            ),
            Column(
              children: [
                Text("Headshot %"),
                Text(headShots.isEmpty ? 'Loading...' : headShots[0])
              ],
            )
          ]),
          Text('Bio'),
          Text(bio),
          Text('Pictures'),
          Text('Interests'),
        ]));
  }
}

