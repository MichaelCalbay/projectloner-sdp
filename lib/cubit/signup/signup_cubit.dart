import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projectloner/repositories/registration/auth_repo.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;
  String? userPass;
  bool exceptionCaught = false;
  SignupCubit({
    required AuthRepository authRepository,
    this.userPass,
  })  : _authRepository = authRepository,
        super(SignupState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SignupStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignupStatus.initial));
    userPass = value;
  }

  void signupWithCredentials() async {
    if (!state.isValid) return;
    try {
      await _authRepository.signUp(
          email: state.email, password: state.password);

      emit(state.copyWith(status: SignupStatus.success));
    } on auth.FirebaseAuthException catch (e) {
      exceptionCaught = true;
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

  bool getExceptionCaught() {
    return exceptionCaught;
  }
}
