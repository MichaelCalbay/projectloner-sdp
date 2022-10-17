// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projectloner/login/screens/login_screen.dart';
import 'package:projectloner/repositories/registration/auth_repo.dart';
import 'package:projectloner/views/home_view.dart';

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
        Duration(seconds: 1),
        (_) => checkEmailVerified(),
      );
    }
  }

  void printMessage() {
    Fluttertoast.showToast(
        msg: "Verification has been sent.",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.green);
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

    printMessage();

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
      ? const HomePage()
      : Scaffold(
          appBar: AppBar(
            title: Text('Email Verification'),
          ),
          body: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'A verification email has been \n sent to your E-mail.\n'
                  'Please allow 2-5 minutes for the email to come through.',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Text(
                  'Note: check your spam e-mail.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.redAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                ElevatedButton.icon(
                  onPressed: canResendEmail
                      ? sendVerificationEmail
                      : () => sendVerificationEmail(),
                  icon: Icon(
                    Icons.email,
                  ),
                  label: Text(
                    'Resend E-mail',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    RepositoryProvider.of<AuthRepository>(context).signOut();
                    FirebaseAuth.instance.signOut();

                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => LoginScreen(
                              isEmailVerified: isEmailVerified,
                            )),
                      ),
                    );
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        );
}
