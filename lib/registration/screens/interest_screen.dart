import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/blocs/onboarding/onboarding_bloc.dart';
import 'package:projectloner/registration/widgets/registration_widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class InterestScreen extends StatelessWidget {
  //final TabController tabController;

  const InterestScreen({
    Key? key,
    //required this.tabController,
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
                children: [],
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
