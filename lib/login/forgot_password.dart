// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future resetPass() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _email.text.trim(),
      );

      Fluttertoast.showToast(
          msg: "Reset link has been sent.",
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.green);
    } on FirebaseAuthException catch (e) {
      //Validations
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "User doesn't exists, Please register.",
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.red);
      } else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(
            msg: "Invalid email.",
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Please enter your email to send you a password reset link.'),
          SizedBox(height: 10),
          Text(
            'Note: Check your spam ',
            style: TextStyle(color: Colors.red),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextField(
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'E-mail',
                    icon: Icon(
                      Icons.email_rounded,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          MaterialButton(
            onPressed: resetPass,
            child: Text(
              'Send',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.deepPurple,
          )
        ],
      ),
    );
  }
}
