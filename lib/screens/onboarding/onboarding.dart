import 'package:chatty/screens/auth/register.dart';
import 'package:flutter/material.dart';

import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

import '../../utils/custom_colors.dart';
import '../auth/login.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      body: OnBoardingSlider(
          trailing: const Text("Login",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: CustomColors.baseColor)),
          trailingFunction: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
          centerBackground: true,
          finishButtonText: "Register",
          finishButtonStyle: const FinishButtonStyle(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0))),
              backgroundColor: CustomColors.baseColor,
              elevation: 5),
          finishButtonTextStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: CustomColors.whiteColor),
          onFinish: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const RegisterScreen()));
          },
          pageBackgroundColor: CustomColors.whiteColor,
          hasSkip: true,
          skipTextButton: const Text(
            'Skip',
            style: TextStyle(fontSize: 16),
          ),
          skipFunctionOverride: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const LoginScreen()));
          },
          totalPage: 3,
          headerBackgroundColor: CustomColors.whiteColor,
          background: [
            Image.asset('assets/images/onboarding_screen_1.png',
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width),
            Image.asset('assets/images/onboarding_screen_2.png',
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width),
            Container(
                padding: const EdgeInsets.only(
                  right: 50,
                ),
                child: Image.asset(
                  'assets/images/onboarding_screen_3.png',
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ))
          ],
          speed: 1.8,
          pageBodies: [
            onboadingContainerWidget('Connecting made simple',
                'Start a conversation, ignite a connection. Discover the joy of instant communication.'),
            onboadingContainerWidget('Your chat, your rules',
                'Share moments, create memories, and chat freely. Chat your way through lifes adventures.'),
            onboadingContainerWidget('Your social circle, one chat away',
                'Chat your way to new friendships. Stay close to the people who matter most.'),
          ]),
    );
  }

  onboadingContainerWidget(String title, String description) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: CustomColors.blackColor),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(description,
              style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.normal,
                  color: CustomColors.greyColor)),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
