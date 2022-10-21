import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projectloner/login/verify_email.dart';
import 'package:projectloner/cubit/signup/signup_cubit.dart';
import 'package:projectloner/blocs/onboarding/onboarding_bloc.dart';
import 'package:projectloner/models/user_model.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String buttonText;
  final TextEditingController? confPwdController;
  final LonerUser? user;
  // final AuthRepository? authRepository;

  const CustomButton({
    Key? key,
    required this.tabController,
    required this.buttonText,
    this.confPwdController,
    this.user,
    // this.authRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () async {
            debugPrint('${tabController.index}');
            //This validates the email_screen
            if (tabController.index == 1) {
              //If fields are empty show the message.
              if (context.read<SignupCubit>().userPass == null ||
                  confPwdController?.text.trim() == '' ||
                  context.read<SignupCubit>().userEmail == null) {
                Fluttertoast.showToast(
                    msg: "Fields can't be empty.",
                    gravity: ToastGravity.BOTTOM,
                    textColor: Colors.red);
              } else if (!(context.read<SignupCubit>().userPass ==
                  confPwdController?.text.trim())) {
                Fluttertoast.showToast(
                    msg: "Passwords don't match.",
                    gravity: ToastGravity.BOTTOM,
                    textColor: Colors.red);
              } else {
                //Otherwise, create empty fields into firestore database.
                tabController.animateTo(tabController.index + 1);
                await context.read<SignupCubit>().signupWithCredentials();
                LonerUser user = LonerUser(
                  id: context.read<SignupCubit>().state.user!.uid,
                  firstName: '',
                  lastName: '',
                  age: 0,
                  gender: '',
                  imageUrls: const [],
                  interests: const [],
                  server: '',
                  mainRole: '',
                  swipedLeft: const [],
                  swipedRight: const [],
                  matches: const [],
                );
                context.read<OnboardingBloc>().add(StartOnboarding(user: user));
              }
              //Validates the gender age screen.
            } else if (tabController.index == 2) {
              //If fields are empty show a message.
              if (user?.firstName == '' ||
                  user?.lastName == '' ||
                  user?.gender == '' ||
                  user?.age == 0) {
                Fluttertoast.showToast(
                    msg: "You've missed a field.",
                    gravity: ToastGravity.BOTTOM,
                    textColor: Colors.red);
              } else {
                //Otherwise, toggle to the next page.
                tabController.animateTo(tabController.index + 1);
              }
              //Validates the last page.
            } else if (tabController.index == 4) {
              //If fields are empty, show a message.
              if (user?.server == '' || user?.mainRole == '') {
                Fluttertoast.showToast(
                    msg: "You've missed a field.",
                    gravity: ToastGravity.BOTTOM,
                    textColor: Colors.red);
              } else {
                //Otherwise, navigate to email verification.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VerifyEmailPage(),
                  ),
                );
              }
              //It goes here if not in the first page or 4th page.
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
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
        );
      },
    );
  }
}
