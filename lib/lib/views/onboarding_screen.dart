import 'package:flutter/material.dart';
import 'package:projectloner/intro/intro_page_1.dart';
import 'package:projectloner/intro/intro_page_2.dart';
import 'package:projectloner/intro/intro_page_3.dart';
import 'package:projectloner/intro/intro_page_4.dart';
import 'package:projectloner/intro/intro_page_5.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../auth/check_login.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  /* KEEP TRACK OFF LAST PAGE */
  bool onLastPage = false;

  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
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
            alignment: const Alignment(0, 0.80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                /* IF NOT ON LAST PAGE */
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          _controller.jumpToPage(4);
                        },
                        child: const Text(''),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.jumpToPage(4);
                        },
                        child: const Text('Skip'),
                      ),
                SmoothPageIndicator(controller: _controller, count: 5),
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          _storeOnboardInfo();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              /* AFTER LAST PAGE RETURN TO HOME PAGE */
                              return const CheckLogin();
                            }),
                          );
                        },
                        child: const Text('Log In'),
                      )
                    : GestureDetector(
                        onTap: () {
                          //FirstTime().once(1);
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
