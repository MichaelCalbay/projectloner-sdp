import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/cubit/signup/signup_cubit.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String buttonText;

  final TextEditingController? confPwController;

  const CustomButton({
    Key? key,
    required this.tabController,
    required this.buttonText,
    this.confPwController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        debugPrint('Index: ${tabController.index}');
        tabController.animateTo(tabController.index + 1);
        if (tabController.index == 2) {
          context.read<SignupCubit>().signupWithCredentials();
          debugPrint('User Created!');
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
