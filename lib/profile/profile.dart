import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:projectloner/stats/user_stats.dart';
import 'package:flutter/material.dart';

import '../blocs/profile/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _mynamecontroller = TextEditingController();
  final TextEditingController _mytagcontroller = TextEditingController();
  final TextEditingController _mybiocontroller = TextEditingController();
  String bio = '';
  List ranks = [' '];
  List rankUrls = [
    'https://media.tenor.com/wpSo-8CrXqUAAAAi/loading-loading-forever.gif'
  ];
  List winPercentages = [' '];
  List killDeathRatios = [' '];
  List scorePerRounds = [' '];
  List headShots = [' '];
  List matchHistoryNew = [' '];
  late DocumentReference docRef;
  String firstName = '';
  String lastName = '';
  String name = '';
  String tag = '';
  String profilePicture =
      'https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png';
  @override
  void initState() {
    super.initState();
    getFireBaseInfo()
        .whenComplete(getRank)
        .whenComplete(getImageUrl)
        .whenComplete(getWinPercentage)
        .whenComplete(getKillDeathRatio)
        .whenComplete(getScorePerRound)
        .whenComplete(getHeadshotPercentage);
    //.whenComplete(getMatchHistory);
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
          tag = snapshot.data()!["valTag"];
          firstName = snapshot.data()!["firstName"];
          lastName = snapshot.data()!["lastName"];
          bio = snapshot.data()!["bio"];
          List profilePics = snapshot.get('imageUrls');
          profilePicture = profilePics[0];
        });
      }
    });
  }

  void saveBio() {
    FirebaseFirestore.instance
        .collection('LonerUser')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'bio': bio});
  }

  void saveTag() {
    FirebaseFirestore.instance
        .collection('LonerUser')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'valTag': tag});
  }

  void saveIgn() {
    FirebaseFirestore.instance
        .collection('LonerUser')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'ign': name});
  }

  Future getRank() async {
    final url = Uri.parse(
        'https://tracker.gg/valorant/profile/riot/$name%23$tag/overview');
    final response = await http.get(url);

    dom.Document html = dom.Document.html(response.body);

    final rank = html
        .querySelectorAll('span.stat__label')
        .map((element) => element.innerHtml)
        .toList();
    setState(() {
      ranks = rank;
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
        .map((element) => element.innerHtml.trim())
        .toList();

    setState(() {
      winPercentages = winPercentage;
    });

    FirebaseFirestore.instance
        .collection('LonerUser')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'winPercentage': winPercentages});
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
    });

    FirebaseFirestore.instance
        .collection('LonerUser')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'scorePerRound': scorePerRounds});
  }

  // Future getMatchHistory() async {
  //   final url = Uri.parse(
  //       'https://tracker.gg/valorant/profile/riot/$name%23$tag/matches');
  //   final response = await http.get(url);
  //   dom.Document html = dom.Document.html(response.body);
//
  //   final matchHistory = html
  //       .querySelectorAll(
  //           'div.card.bordered.header-bordered.responsive.matches > div > div > div > div')
  //       .map((e) => e.innerHtml.trim())
  //       .toList();
//
  //   setState(() {
  //     matchHistoryNew = matchHistory;
  //   });
  // }

  Future getKillDeathRatio() async {
    final url = Uri.parse(
        'https://tracker.gg/valorant/profile/riot/$name%23$tag/overview');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final killDeathRadio = html
        .querySelectorAll('div:nth-child(1) > div > div.numbers > span.value')
        .map((e) => e.innerHtml.trim())
        .toList();

    setState(() {
      killDeathRatios = killDeathRadio;
    });

    FirebaseFirestore.instance
        .collection('LonerUser')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'kdRatio': killDeathRatios});
  }

  Future getHeadshotPercentage() async {
    final url = Uri.parse(
        'https://tracker.gg/valorant/profile/riot/$name%23$tag/overview');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final headshotPercentage = html
        .querySelectorAll('div:nth-child(2) > div > div.numbers > span.value')
        .map((element) => element.innerHtml.trim())
        .toList();

    setState(() {
      headShots = headshotPercentage;
    });

    FirebaseFirestore.instance
        .collection('LonerUser')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'headshotPercentage': headshotPercentage});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProfileLoaded) {
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
              centerTitle: true,
              title: const Text('Profile'),
              backgroundColor: Colors.deepPurple,
            ),
            body: ListView(padding: EdgeInsets.zero, children: [
              const SizedBox(height: 11),
              SizedBox(
                height: 128,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  maxRadius: 128,
                  minRadius: 128,
                  child: ClipOval(
                    child: Image.network((state.user.imageUrls.isEmpty)
                        ? ((state.user.gender == 'Male')
                            ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZxub6hsCPpJFn6jmQvDl5CDJLroGdg-yLXJV1KcCHMjKpuwd8E6zJ7X6U3TUEjlS59ig&usqp=CAU'
                            : ((state.user.gender == 'Female')
                                ? 'https://us.123rf.com/450wm/apoev/apoev1902/apoev190200082/125259956-person-gray-photo-placeholder-woman-in-shirt-on-white-background.jpg?ver=6'
                                : 'https://dthezntil550i.cloudfront.net/3w/latest/3w1802281317020600001818004/1280_960/45b9e268-7f83-4d2a-98cb-8843e805359b.png'))
                        : state.user.imageUrls[0]),
                  ),
                ),
              ),
              Text(
                '$firstName' ' ' '',
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Column(children: [
                Text(
                  '(' '' ')',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ranks.isEmpty ? 'No Rank This Season' : ranks[0],
                  textAlign: TextAlign.center,
                ),
                CircleAvatar(
                  maxRadius: 24,
                  minRadius: 24,
                  backgroundColor: Colors.transparent,
                  child: Image.network(
                    rankUrls.isEmpty
                        ? 'https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png'
                        : rankUrls[0],
                  ),
                ),
              ]),
              ListView(shrinkWrap: true, children: [
                Row(children: [
                  SizedBox(
                    width: 6,
                  ),
                  Column(children: [
                    Text("Win Percentage"),
                    Text(winPercentages.isEmpty ? ' ' : winPercentages[0]),
                  ]),
                  SizedBox(
                    width: 27,
                  ),
                  Column(
                    children: [
                      Text("K/D Ratio"),
                      Text(killDeathRatios.isEmpty ? '' : killDeathRatios[0]),
                    ],
                  ),
                  SizedBox(
                    width: 27,
                  ),
                  Column(
                    children: [
                      Text("Score/Round"),
                      Text(scorePerRounds.isEmpty ? ' ' : scorePerRounds[0]),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text("Headshot %"),
                      Text(headShots.isEmpty ? ' ' : headShots[0])
                    ],
                  )
                ]),
              ]),
              Text(
                killDeathRatios.isEmpty ? 'Invalid In Game Name or Tag' : ' ',
                textAlign: TextAlign.center,
              ),
              Text('In Game Name:'),
              TextField(
                  maxLength: 10,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple)),
                    hintText: name,
                  ),
                  controller: _mynamecontroller,
                  onChanged: (text) {
                    setState(() {
                      name = text;
                    });
                    saveIgn();
                  }),
              Text("Tag:"),
              TextField(
                  maxLength: 6,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple)),
                    hintText: tag,
                  ),
                  controller: _mytagcontroller,
                  onChanged: (text) {
                    setState(() {
                      tag = text;
                    });
                    saveTag();
                  }),
              const Text("Bio:"),
              TextField(
                  maxLength: 50,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple)),
                    hintText: bio,
                  ),
                  controller: _mybiocontroller,
                  onChanged: (text) {
                    setState(() {
                      bio = text;
                    });
                    saveBio();
                  }),
            ]),
          );
        } else {
          return const Text('Oops, something went wrong...');
        }
      },
    );
  }
}
