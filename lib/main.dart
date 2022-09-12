// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectloner/auth/CheckLogin.dart';
import 'package:projectloner/auth/LoginPage.dart';
import 'package:instabug_flutter/instabug_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    /*  BUG REPORTING SAM */
    super.initState();
    Instabug.start('204ec6dbacf517d824009b10798d3abd', [InvocationEvent.none]);
    Replies.setEnabled(false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckLogin(),
      //Theme colour
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}
