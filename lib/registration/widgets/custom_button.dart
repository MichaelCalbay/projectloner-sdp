import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projectloner/cubit/signup/signup_cubit.dart';
import 'package:projectloner/repositories/registration/auth_repo.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String buttonText;
  final TextEditingController? confPwdController;
  //final AuthRepository? authRepository;

  const CustomButton({
    Key? key,
    required this.tabController,
    required this.buttonText,
    this.confPwdController,
    //this.authRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (context.read<SignupCubit>().userPass ==
            confPwdController?.text.trim()) {
          tabController.animateTo(tabController.index + 1);
          if (tabController.index == 2) {
            context.read<SignupCubit>().signupWithCredentials();
          }
        } else {
          Fluttertoast.showToast(
              msg: "Passwords don't match.",
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.red);
        }
      },
      // ignore: sized_box_for_whitespace
      child: Container(
        width: double.infinity,
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
