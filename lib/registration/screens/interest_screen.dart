import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/blocs/onboarding/onboarding_bloc.dart';
import 'package:projectloner/registration/widgets/registration_widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class InterestScreen extends StatelessWidget {
  final TabController tabController;

  const InterestScreen({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 10,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: const [
                CustomTextHeader(
                  text: "Pick your interests",
                ),
                SizedBox(height: 5),
              ],
            ),
            const SizedBox(height: 370),
            Column(
              children: [
                const AlreadyLoner(),
                const SizedBox(height: 10),
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
      ),
    );
  }
}
