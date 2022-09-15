// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectloner/auth/LoginPage.dart';
import 'package:projectloner/views/onboarding_screen.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;
  bool canResendEmail = false;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    //Checks if email is already verified every 3 seconds.
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  Future sendVerificationEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.sendEmailVerification();

    //Resend email every 5 seconds when user can actually resend it.
    setState(() {
      canResendEmail = false;
    });
    await Future.delayed(Duration(seconds: 5));
    setState(() {
      canResendEmail = true;
    });
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const OnboardingScreen()
      : Scaffold(
          appBar: AppBar(
            title: Text('Email Verification'),
          ),
          body: Padding(
            padding: EdgeInsets.all(25),
            // ignore: prefer_const_literals_to_create_immutables
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'A verification email has been sent to your E-mail.',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Text(
                'Note: check your spam e-mail.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.redAccent,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: canResendEmail
                    ? sendVerificationEmail
                    : () => sendVerificationEmail(),
                icon: Icon(
                  Icons.email,
                ),
                label: Text(
                  'Resent E-mail',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 20),
                ),
              )
            ]),
          ),
        );
}
