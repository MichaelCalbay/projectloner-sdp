import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/cubit/signup/signup_cubit.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String buttonText;

  const CustomButton({
    Key? key,
    required this.tabController,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        //NEED TO WORK ON VALIDATION
        if (tabController.index == 2) {
          if (context.read<SignupState>().isValid) {
            context.read<SignupCubit>().signupWithCredentials();
            if (context.read<SignupCubit>().exceptionCaught) {
              debugPrint("Exception Caught!");
            } else {
              tabController.animateTo(tabController.index + 1);
            }
          }
        } else {
          tabController.animateTo(tabController.index + 1);
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
