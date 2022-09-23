import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectloner/auth/auth_page.dart';
import 'package:projectloner/auth/verify_email.dart';
import 'package:projectloner/registration/registration_page.dart';
import 'package:projectloner/views/home_view.dart';

class CheckLogin extends StatelessWidget {
  const CheckLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              return const RegistrationPage();
            }
          }),
    );
  }
}
