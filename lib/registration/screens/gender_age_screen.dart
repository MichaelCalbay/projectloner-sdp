import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/blocs/onboarding/onboarding_bloc.dart';
import 'package:projectloner/registration/widgets/registration_widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class GenderAgeScreen extends StatelessWidget {
  final TabController tabController;
  const GenderAgeScreen({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OnboardingLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 10.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const CustomTextHeader(
                        text: "What's your Firstname?",
                      ),
                      const SizedBox(height: 5),
                      CustomTextField(
                        isTextOnly: false,
                        isPassword: false,
                        hint: 'Enter your firstname...',
                        onChanged: (value) {
                          context.read<OnboardingBloc>().add(
                                UpdateUser(
                                  user: state.user.copyWith(
                                    firstName: value,
                                  ),
                                ),
                              );
                        },
                      ),
                      const SizedBox(height: 10),
                      const CustomTextHeader(
                        text: "What's your Lastname?",
                      ),
                      const SizedBox(height: 5),
                      CustomTextField(
                        isTextOnly: false,
                        isPassword: false,
                        hint: 'Enter your lastname...',
                        onChanged: (value) {
                          context.read<OnboardingBloc>().add(
                                UpdateUser(
                                  user: state.user.copyWith(lastName: value),
                                ),
                              );
                        },
                      ),
                      const SizedBox(height: 10),
                      const CustomTextHeader(
                        text: "What's Your Gender?",
                      ),
                      const SizedBox(height: 10),
                      CustomCheckbox(
                        text: 'MALE',
                        value: state.user.gender == 'Male',
                        onChanged: (bool? newValue) {
                          context.read<OnboardingBloc>().add(
                                UpdateUser(
                                  user: state.user.copyWith(gender: 'Male'),
                                ),
                              );
                        },
                      ),
                      CustomCheckbox(
                        text: 'FEMALE',
                        value: state.user.gender == 'Female',
                        onChanged: (bool? newValue) {
                          context.read<OnboardingBloc>().add(
                                UpdateUser(
                                  user: state.user.copyWith(gender: 'Female'),
                                ),
                              );
                        },
                      ),
                      CustomCheckbox(
                        text: 'OTHER',
                        value: state.user.gender == 'Other',
                        onChanged: (bool? newValue) {
                          context.read<OnboardingBloc>().add(
                                UpdateUser(
                                  user: state.user.copyWith(gender: 'Other'),
                                ),
                              );
                        },
                      ),
                      const SizedBox(height: 50),
                      const CustomTextHeader(
                        text: "How Old Are You?",
                      ),
                      const SizedBox(height: 5.0),
                      CustomTextNumberField(
                        isPassword: false,
                        hint: 'Age here...',
                        onChanged: (value) {
                          context.read<OnboardingBloc>().add(
                                UpdateUser(
                                  user: state.user.copyWith(
                                    age: int.parse(value),
                                  ),
                                ),
                              );
                        },
                      ),
                      const SizedBox(height: 140),
                    ],
                  ),
                  Column(
                    children: [
                      const AlreadyLoner(),
                      const SizedBox(height: 10),
                      const StepProgressIndicator(
                        totalSteps: 5,
                        currentStep: 3,
                        selectedColor: Colors.deepPurple,
                      ),
                      CustomButton(
                        user: state.user,
                        buttonText: 'NEXT',
                        tabController: tabController,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Text('Oops, something went wrong!');
        }
      },
    );
  }
}
