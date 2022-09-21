import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:projectloner/repositories/registration/auth_repo.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;

  SignupCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignupState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SignupStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignupStatus.initial));
  }

  void signupWithCredentials() async {
    if (!state.isValid) {
      debugPrint('NOT VALID');
      return;
    }
    try {
      await _authRepository.signUp(
          email: state.email, password: state.password);
      debugPrint('IM INSIDE AUTH REPO SIGNUP');
      emit(state.copyWith(status: SignupStatus.success));
    } catch (_) {}
  }
}
