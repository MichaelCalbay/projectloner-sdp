import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projectloner/cubit/signup/signup_cubit.dart';
import 'package:projectloner/repositories/registration/auth_repo.dart';
import 'package:projectloner/blocs/onboarding/onboarding_bloc.dart';
import 'package:projectloner/cubit/signup/signup_cubit.dart';
import 'package:projectloner/models/user_model.dart';
import 'package:projectloner/views/home_view.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String buttonText;
  final TextEditingController? confPwdController;

  const CustomButton({
    Key? key,
    required this.tabController,
    required this.buttonText,
    this.confPwdController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        //NEED TO WORK ON VALIDATION
        debugPrint('${tabController.index}');
        if (tabController.index == 4) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        } else {
          tabController.animateTo(tabController.index + 1);
        }

        if (tabController.index == 2) {
          if (!(context.read<SignupCubit>().userPass ==
              confPwdController?.text.trim())) {
            Fluttertoast.showToast(
                msg: "Passwords don't match.",
                gravity: ToastGravity.BOTTOM,
                textColor: Colors.red);
          } else {
            await context.read<SignupCubit>().signupWithCredentials();

            LonerUser user = LonerUser(
              id: context.read<SignupCubit>().state.user!.uid,
              firstName: '',
              lastName: '',
              age: 0,
              gender: '',
              imageUrls: [],
              server: '',
              mainRole: '',
            );
            context.read<OnboardingBloc>().add(StartOnboarding(user: user));
          }
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
