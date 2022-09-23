import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projectloner/repositories/registration/auth_repo.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;
  String? userPass;
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
    } catch (_) {}
    // on auth.FirebaseAuthException catch (e) {
    //   exceptionCaught = true;
    //   if (e.code == 'weak-password') {
    //     Fluttertoast.showToast(
    //         msg: "Password is weak.",
    //         gravity: ToastGravity.BOTTOM,
    //         textColor: Colors.red);
    //   } else if (e.code == 'email-already-in-use') {
    //     Fluttertoast.showToast(
    //         msg: "Email already exists.",
    //         gravity: ToastGravity.BOTTOM,
    //         textColor: Colors.red);
    //   } else if (e.code == 'invalid-email') {
    //     Fluttertoast.showToast(
    //         msg: "Invalid email.",
    //         gravity: ToastGravity.BOTTOM,
    //         textColor: Colors.red);
    //   }
    // }
  }
}
