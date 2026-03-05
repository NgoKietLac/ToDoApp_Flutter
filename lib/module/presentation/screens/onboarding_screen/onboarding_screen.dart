import 'package:app_todo_application/module/presentation/screens/sign_in_screen/sign_in_screen.dart';
import 'package:app_todo_application/module/resources/app_styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  final CarouselSliderController controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentGeometry.topCenter,
                end: AlignmentGeometry.bottomCenter,
                colors: <Color>[Color(0xFF1253AA), Color(0xFF05243E)],
              ),
            ),
          ),
          CarouselSlider(
            carouselController: controller,
            items: [
              //Trang 1
              Container(
                margin: EdgeInsets.only(left: 70, right: 67),
                child: Padding(
                  padding: EdgeInsets.all(1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 55),
                      Image.asset("assets/image/1.png"),
                      SizedBox(height: 65),
                      Text(
                        "Plan your tasks to do, that way you’ll stay organized and you won’t skip any",
                        textAlign: TextAlign.center,
                        style: AppStyles.headingStyle,
                      ),
                    ],
                  ),
                ),
              ),
              //Trang 2
              Container(
                margin: EdgeInsets.only(left: 70, right: 67),
                child: Padding(
                  padding: EdgeInsets.all(1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 60),
                      Image.asset("assets/image/2.png"),
                      SizedBox(height: 60),
                      Text(
                        "Make a full schedule for the whole week and stay organized and productive all days",
                        textAlign: TextAlign.center,
                        style: AppStyles.headingStyle,
                      ),
                    ],
                  ),
                ),
              ),
              //Trang 3
              Container(
                margin: EdgeInsets.only(left: 70, right: 67),
                child: Padding(
                  padding: EdgeInsets.all(1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 92),
                      Image.asset("assets/image/3.png"),
                      SizedBox(height: 97),
                      Text(
                        "create a team task, invite people and manage your work together",
                        textAlign: TextAlign.center,
                        style: AppStyles.headingStyle,
                      ),
                    ],
                  ),
                ),
              ),
              //Trang 4
              Container(
                margin: EdgeInsets.only(left: 70, right: 67),
                child: Padding(
                  padding: EdgeInsets.all(1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 74),
                      Image.asset("assets/image/4.png"),
                      SizedBox(height: 79),
                      Text(
                        "You informations are secure with us",
                        textAlign: TextAlign.center,
                        style: AppStyles.headingStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ],
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          Positioned(
            bottom: 50,
            left: 30,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(4, (index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: _currentIndex == index ? 25 : 10,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(
                          alpha: _currentIndex == index ? 1.0 : 0.3,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    );
                  }),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_currentIndex < 3) {
                      controller.nextPage(
                        duration: Duration(milliseconds: 300),
                      );
                    } else {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isFirstTime', false);
                      if (mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    fixedSize: Size(70, 70),
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.white,
                  ),
                  child: Icon(
                    _currentIndex == 3
                        ? Icons.check
                        : Icons.arrow_forward_rounded,
                    size: 40,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
