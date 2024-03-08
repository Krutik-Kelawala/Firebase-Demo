import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project/e-commerce%20app/dashboard/dashboard.dart';
import 'package:test_project/e-commerce%20app/login_screen/login_screen.dart';
import 'package:test_project/utilities/common_logic.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CommonLogic.firebaseEventTrack("Splash_Screen");
  }

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return user != null ? const DashboardScreen() : const LoginScreen();
        },
      ), (route) => false),
    );

    return Scaffold(
      body: SafeArea(
        child: Image.asset(
          "assets/images/ecommerce/wear me.webp",
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
