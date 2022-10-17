import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projectloner/repositories/registration/base_auth_repo.dart';

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  static bool isValid = true;

  AuthRepository({isValid, auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Future<auth.User?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      isValid = true;
      // debugPrint('$isValid');
      return user;
    } on auth.FirebaseAuthException catch (e) {
      isValid = false;
      // debugPrint('$isValid');
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
            msg: "Password is weak.",
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.red);
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "Email already exists.",
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
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  auth.FirebaseAuth getAuth() {
    return _firebaseAuth;
  }
}
