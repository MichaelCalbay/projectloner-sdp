import 'package:flutter/material.dart';
import 'package:projectloner/intro/IntroPage_1.dart';
import 'package:projectloner/intro/IntroPage_2.dart';
import 'package:projectloner/intro/IntroPage_3.dart';
import 'package:projectloner/intro/IntroPage_4.dart';
import 'package:projectloner/intro/IntroPage_5.dart';
import 'package:projectloner/views/HomeView.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final PageController _controller = PageController();
  
  /* KEEP TRACK OFF LAST PAGE */ 
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index){
              setState(() {
                onLastPage = (index == 4);
              });
            },
            children: const [
              /* INTRO PAGES */
              PageOne(),
              PageTwo(),
              PageThree(),
              PageFour(),
              PageFive(),
            ],
          ),
          Container(
            alignment: const Alignment(0,0.80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    _controller.jumpToPage(4);
                  },
                  child: const Text('Skip'),
                ),
                SmoothPageIndicator(controller: _controller, count: 5),
                onLastPage ?
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      /* AFTER LAST PAGE RETURN TO HOME PAGE */
                      return const HomePage();
                    }),
                    );
                  },
                  child: const Text('Done'),
                )
                : GestureDetector(
                  onTap: (){
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 500), 
                    curve: Curves.easeIn);
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    ); 
  }
}