// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectloner/login/screens/login_screen.dart';
import 'package:projectloner/login/verify_email.dart';
import 'package:projectloner/views/home_view.dart';

class CheckLogin extends StatelessWidget {
  final bool? isEmailVerified;
  const CheckLogin({Key? key, this.isEmailVerified}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (isEmailVerified == true) {
                return HomePage();
              } else {
                return VerifyEmailPage();
              }
            } else {
              return LoginScreen();
            }
          }),
    );
  }
}
