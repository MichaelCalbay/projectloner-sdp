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
                    int count = state.imageUrls.length;

                    return SizedBox(
                      height: 350,
                      //Returning 6 Containers
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, childAspectRatio: 0.66),
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index) {
                            return (count > index)
                                //Will return a container with an image if count > index.
                                ? CustomImageCont(
                                    imageUrl: state.imageUrls[index])
                                //else, it will return an empty container.
                                : const CustomImageCont();
                          }),
                    );
                    //Old hard coded 6 containers
                    // return Wrap(
                    //   children: [
                    //     (count > 0)
                    //         ? CustomImageCont(imageUrl: state.imageUrls[0])
                    //         : const CustomImageCont(),
                    //     (count > 1)
                    //         ? CustomImageCont(imageUrl: state.imageUrls[1])
                    //         : const CustomImageCont(),
                    //     (count > 2)
                    //         ? CustomImageCont(imageUrl: state.imageUrls[2])
                    //         : const CustomImageCont(),
                    //     (count > 3)
                    //         ? CustomImageCont(imageUrl: state.imageUrls[3])
                    //         : const CustomImageCont(),
                    //     (count > 4)
                    //         ? CustomImageCont(imageUrl: state.imageUrls[4])
                    //         : const CustomImageCont(),
                    //     (count > 5)
                    //         ? CustomImageCont(imageUrl: state.imageUrls[5])
                    //         : const CustomImageCont(),
                    //   ],
                    // );
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
