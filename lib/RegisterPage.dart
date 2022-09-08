// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _fName;
  late final TextEditingController _lName;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _conPassword;
  late final TextEditingController _mblNo;
  late final TextEditingController _sex;
  late final TextEditingController _dob;

  @override
  void initState() {
    _fName = TextEditingController();
    _lName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _conPassword = TextEditingController();
    _mblNo = TextEditingController();
    _sex = TextEditingController();
    _dob = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _fName.dispose();
    _lName.dispose();
    _email.dispose();
    _password.dispose();
    _conPassword.dispose();
    _mblNo.dispose();
    _sex.dispose();
    _dob.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _fName,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(hintText: 'First Name'),
                  ),
                  TextField(
                    controller: _lName,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(hintText: 'Last Name'),
                  ),
                  TextField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: 'E-mail'),
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(hintText: 'Password'),
                  ),
                  TextField(
                    controller: _mblNo,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.phone,
                    decoration:
                        const InputDecoration(hintText: 'Mobile number'),
                  ),
                  TextField(
                    controller: _dob,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.keyboard_arrow_down),
                      labelText: "Enter Date",
                    ),
                  ),

                  //------------------------------------------------------------
                  TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try {
                        final userCred = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: email, password: password);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('PASSWORD IS WEAK!');
                        } else if (e.code == 'email-already-in-use') {
                          print('EMAIL ALREADY EXISTS!');
                        } else if (e.code == 'invalid-email') {
                          print('INVALID EMAIL');
                        }
                      }
                    },
                    child: const Text('Register'),
                  ),
                  const Text('Already have an account?'),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login/', (route) => false);
                      },
                      child: const Text('Log in'))
                ],
              );
            default:
              return const Text('Loading..');
          }
        },
      ),
    );
  }
}
