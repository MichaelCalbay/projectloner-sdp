import 'package:flutter/material.dart';
import 'package:projectloner/registration/widgets/registration_widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Start extends StatelessWidget {
  final TabController tabController;

  const Start({
    Key? key,
    required this.tabController,
  }) : super(key: key);

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
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                height: 200,
                width: 200,
                child: const Icon(
                  Icons.gamepad_rounded,
                  size: 100,
                  color: Colors.deepPurple,
                ),
              ),
              const Text(
                'Welcome to Loner',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Please be respectful to others at all times, toxicity will not be tolerated! We are all here to have fun and make friends. Enjoy your time and get gaming!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                  height: 2.0,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const AlreadyLoner(),
              const SizedBox(height: 10),
              const StepProgressIndicator(
                totalSteps: 6,
                currentStep: 1,
                selectedColor: Colors.deepPurple,
              ),
              CustomButton(
                buttonText: 'START',
                tabController: tabController,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
