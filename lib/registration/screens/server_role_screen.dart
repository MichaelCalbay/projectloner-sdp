import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/blocs/onboarding/onboarding_bloc.dart';
import 'package:projectloner/registration/widgets/registration_widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ServerRole extends StatelessWidget {
  final TabController tabController;
  const ServerRole({Key? key, required this.tabController}) : super(key: key);

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    const CustomTextHeader(
                      text: 'What Server Do You Play On?',
                    ),
                    CustomDropdown(),
                    const SizedBox(height: 25),
                    const CustomTextHeader(
                      text: "What's your best role?",
                    ),
                    const SizedBox(height: 5),
                    CustomCheckbox(
                      text: 'DUELIST',
                      value: state.user.mainRole == 'Duelist',
                      onChanged: (bool? newValue) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(
                                user: state.user.copyWith(mainRole: 'Duelist'),
                              ),
                            );
                      },
                    ),
                    CustomCheckbox(
                      text: 'CONTROLLER',
                      value: state.user.mainRole == 'Controller',
                      onChanged: (bool? newValue) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(
                                user:
                                    state.user.copyWith(mainRole: 'Controller'),
                              ),
                            );
                      },
                    ),
                    CustomCheckbox(
                      text: 'INITIATOR',
                      value: state.user.mainRole == 'Initiator',
                      onChanged: (bool? newValue) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(
                                user:
                                    state.user.copyWith(mainRole: 'Initiator'),
                              ),
                            );
                      },
                    ),
                    CustomCheckbox(
                      text: 'SUPPORT',
                      value: state.user.mainRole == 'Support',
                      onChanged: (bool? newValue) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(
                                user: state.user.copyWith(mainRole: 'Support'),
                              ),
                            );
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    const StepProgressIndicator(
                      totalSteps: 5,
                      currentStep: 5,
                      selectedColor: Colors.deepPurple,
                    ),
                    CustomButton(
                      buttonText: 'FINISH',
                      tabController: tabController,
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Text('Oops, something went wrong!');
        }
      },
    );
  }
}
