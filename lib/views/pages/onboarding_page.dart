import 'package:bazar/constants/app_colors.dart';
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>> infos = [
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
                    padding: const EdgeInsets.all(35.0),
                    child: Column(
                      children: [
                        Image.asset(
                          infos.elementAt(index)[0],
                          height: 320,
                          width: 320,
                          fit: BoxFit.contain,
                        ),
                        Text(
                          infos.elementAt(index)[1],
                          style: TextStyle(
                            color: AppColors.greyscale900,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          infos.elementAt(index)[2],
                          style: TextStyle(
                            color: AppColors.greyscale500,
                            fontSize: 16,
                          ),
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
              SizedBox(height: 50),
              PurpleButtonWidget(text: infos.elementAt(currentIndex)[3]),
              SizedBox(height: 5),
              PurpleButtonWidget(text: "Sign in", isSwitched: true),
            ],
          ),
        ),
      ),
    );
  }
}
