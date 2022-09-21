import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:projectloner/repositories/registration/base_auth_repo.dart';
import 'package:flutter/material.dart';

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;

  AuthRepository({auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Future<auth.User?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      return user;
    } catch (_) {}
  }

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();
}
