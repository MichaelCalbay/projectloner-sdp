import 'package:flutter/material.dart';
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
    final controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 10.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              CustomTextHeader(
                tabController: tabController,
                text: "What's Your Gender?",
              ),
              const SizedBox(height: 10),
              CustomCheckbox(
                tabController: tabController,
                text: 'MALE',
              ),
              CustomCheckbox(
                tabController: tabController,
                text: 'FEMALE',
              ),
              CustomCheckbox(
                tabController: tabController,
                text: 'OTHER',
              ),
              const SizedBox(height: 50),
              CustomTextHeader(
                tabController: tabController,
                text: "How Old Are You?",
              ),
              const SizedBox(height: 5.0),
              CustomTextField(
                isPassword: false,
                confPwdController: controller,
                hint: 'Age here...',
              ),
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
                buttonText: 'NEXT',
                tabController: tabController,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
