import 'package:flutter/material.dart';
import 'package:projectloner/registration/widgets/registration_widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ServerRole extends StatelessWidget {
  final TabController tabController;
  const ServerRole({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              CustomTextHeader(
                tabController: tabController,
                text: 'What Server Do You Play On?',
              ),
              CustomDropdown(tabController: tabController),
              const SizedBox(height: 25),
              CustomTextHeader(
                tabController: tabController,
                text: 'What Roles Do You Play?',
              ),
              const SizedBox(height: 5),
              CustomCheckbox(tabController: tabController, text: 'DUELIST'),
              CustomCheckbox(tabController: tabController, text: 'CONTROLLER'),
              CustomCheckbox(tabController: tabController, text: 'INITIATOR'),
              CustomCheckbox(tabController: tabController, text: 'SUPPORT'),
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
  }
}
