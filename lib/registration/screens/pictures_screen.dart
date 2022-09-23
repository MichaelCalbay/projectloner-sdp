import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/blocs/onboarding/onboarding_bloc.dart';
import 'package:projectloner/registration/widgets/registration_widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Pictures extends StatelessWidget {
  final TabController tabController;
  const Pictures({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OnboardingLoaded) {
          var images = state.user.imageUrls;
          var imageCount = images.length;

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
                      text: 'Add 2 or More Pictures',
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 350,
                      //Returning 6 Containers
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, childAspectRatio: 0.66),
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index) {
                            return (imageCount > index)
                                //Will return a container with an image if count > index.
                                ? CustomImageCont(imageUrl: images[index])
                                //else, it will return an empty container.
                                : const CustomImageCont();
                          }),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const StepProgressIndicator(
                      totalSteps: 5,
                      currentStep: 4,
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
        } else {
          return const Text('Oops, something went wrong!');
        }
      },
    );
  }
}
