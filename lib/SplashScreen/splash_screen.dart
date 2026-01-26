import 'dart:async';

import 'package:app_todo_application/OnboardingScreen/onboarding_screen.dart';
import 'package:app_todo_application/resources/app_styles.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter,
            colors: <Color>[Color(0xFF1253AA), Color(0xFF05243E)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 143),
              Image.asset('assets/icon/Checkmark.png', width: 100, height: 100),
              SizedBox(height: 23),
              Text("DO IT", style: AppStyles.logoStyle),
              SizedBox(height: 228),
              Text("v 1.0.0", style: AppStyles.bodyStyle),
            ],
          ),
        ),
      ),
    );
  }
}
