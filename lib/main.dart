// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'views/HomeView.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/auth/CheckLogin.dart';
import 'package:instabug_flutter/instabug_flutter.dart';
import 'package:projectloner/blocs/swipe/swipe_bloc.dart';
import 'package:projectloner/matching/matching_screen.dart';
import 'package:projectloner/views/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/models.dart';

int? isviewed;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {  
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SwipeBloc()
            ..add(
              LoadUsers(users: LonerUser.users),
            ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Project: Loner',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
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
      home: isviewed != 0 ? OnboardingScreen() : CheckLogin(),

      //Theme colour
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}
