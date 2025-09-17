import 'package:bazar/constants/app_colors.dart';
import 'package:bazar/constants/ktext_styles.dart';
import 'package:bazar/views/pages/sign_in_page.dart';
import 'package:bazar/views/pages/sign_up_page.dart';
import 'package:bazar/views/widgets/purple_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  List<List<dynamic>> infos = [
    [
      "assets/images/onboarding1.png",
      "Now reading books will be easier",
      "Discover new worlds, join a vibrant reading community. Start your reading adventure effortlessly with us.",
      "Continue",
    ],
    [
      "assets/images/onboarding2.png",
      "Your Bookish Soulmate Awaits",
      "Let us be your guide to the perfect read. Discover books tailored to your tastes for a truly rewarding experience.",
      "Continue",
    ],
    [
      "assets/images/onboarding3.png",
      "Start Your Adventure",
      "Ready to embark on a quest for inspiration and knowledge? Your adventure begins now. Let's go!",
      "Get Started",
    ],
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (currentIndex < infos.length - 1) {
      currentIndex++;
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  "Skip",
                  style: TextStyle(
                    color: AppColors.primary500,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  onPageChanged: (value) => setState(() {
                    currentIndex = value;
                  }),
                  controller: _pageController,
                  itemCount: 3,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          infos.elementAt(index)[0],
                          height: 250,
                          fit: BoxFit.contain,
                        ),
                        Text(
                          infos.elementAt(index)[1],
                          style: KtextStyles.heading3,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          infos.elementAt(index)[2],
                          style: KtextStyles.bodyregular16,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: WormEffect(
                    activeDotColor: AppColors.primary500,
                    dotHeight: 8,
                    dotWidth: 8,
                    dotColor: AppColors.greyscale200,
                    spacing: 6,
                  ),
                  onDotClicked: (index) {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                ),
              ),
              SizedBox(height: 30),
              PurpleButtonWidget(
                text: infos.elementAt(currentIndex)[3],
                onPressed: nextPage,
              ),
              SizedBox(height: 5),
              PurpleButtonWidget(
                text: "Sign in",
                isSwitched: true,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
