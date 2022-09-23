import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/blocs/images/images_bloc.dart';
import 'package:projectloner/registration/widgets/registration_widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Pictures extends StatelessWidget {
  final TabController tabController;
  const Pictures({Key? key, required this.tabController}) : super(key: key);

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
                text: 'Add 2 or More Pictures',
              ),
              const SizedBox(height: 15),
              BlocBuilder<ImagesBloc, ImagesState>(
                builder: (context, state) {
                  if (state is ImagesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ImagesLoaded) {
                    return Wrap(
                      children: [
                        CustomImageCont(tabController: tabController),
                        CustomImageCont(tabController: tabController),
                        CustomImageCont(tabController: tabController),
                        CustomImageCont(tabController: tabController),
                        CustomImageCont(tabController: tabController),
                        CustomImageCont(tabController: tabController),
                      ],
                    );
                  } else {
                    return const Text('Oops, something went wrong!');
                  }
                },
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
  }
}
