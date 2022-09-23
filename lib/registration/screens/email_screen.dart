import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/cubit/signup/signup_cubit.dart';
import 'package:projectloner/registration/widgets/registration_widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class EmailScreen extends StatelessWidget {
  final TabController tabController;
  final confPwController = TextEditingController();

  EmailScreen({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const CustomTextHeader(
                    text: "What's your Email Address?",
                  ),
                  const SizedBox(height: 5),
                  CustomTextField(
                    isPassword: false,
                    hint: 'Enter your email...',
                    onChanged: (value) {
                      context.read<SignupCubit>().emailChanged(value);
                      debugPrint(state.email);
                    },
                  ),
                  const SizedBox(height: 10),
                  const CustomTextHeader(
                    text: "Password?",
                  ),
                  const SizedBox(height: 5),
                  CustomTextField(
                    isPassword: true,
                    hint: 'Enter password...',
                    onChanged: (value) {
                      context.read<SignupCubit>().passwordChanged(value);
                      debugPrint(state.password);
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextHeader(
                    text: "Confirm Password",
                  ),
                  const SizedBox(height: 5),
                  CustomTextField(
                    confPwController: confPwController,
                    isPassword: true,
                    hint: 'Confirm here..',
                    // onChanged: (value) {
                    //   debugPrint('CONFIRM PASS VAR: ${confPwController.text}');
                    //   debugPrint(
                    //       'PASSWORD VAR: ${context.read<SignupCubit>().userPass}');
                    //   if (context.read<SignupCubit>().userPass ==
                    //       confPwController.text) {
                    //     debugPrint('passwordMatched');
                    //   }
                    // },
                  ),
                ],
              ),
              Column(
                children: [
                  const StepProgressIndicator(
                    totalSteps: 5,
                    currentStep: 2,
                    selectedColor: Colors.deepPurple,
                  ),
                  CustomButton(
                    buttonText: 'NEXT',
                    tabController: tabController,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
