import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../utils/constants.dart';
import '../../utils/custom_colors.dart';
import 'onboarding.dart';
import '../chat/tab.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    var user = Provider.of<UserProvider>(context, listen: false);
    user.initUserProvider();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, navigate);
  }

  navigate() {
    if (_auth.currentUser?.uid != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TabScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.baseColor,
      body: Center(
          child: Text(
        ConstantsData.appName,
        style: GoogleFonts.courgette(
            textStyle: const TextStyle(
          fontSize: 70,
          fontWeight: FontWeight.bold,
          color: CustomColors.whiteColor,
        )),
      )),
    );
  }
}
