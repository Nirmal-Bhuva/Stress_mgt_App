import 'dart:async';

import 'package:flutter/material.dart';
import 'package:relaxio/pages/splash_services/splash_services.dart';
//import 'package:get/get.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _opacityController;
  late AnimationController _rotationController;
  late double _opacity;

  SplashServices splashScreen = SplashServices();

  @override
  void initState() {
    super.initState();
    splashScreen.isLogin(context);
    _opacity = 0.0;

    // Animation controller for opacity
    _opacityController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Animation controller for rotating virus image
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _startAnimation();
  }

  @override
  void dispose() {
    _opacityController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // Background color of the splash screen
      backgroundColor: Color(0xff8e97fd),
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _opacityController,
            builder: (BuildContext context, Widget? child) {
              return Opacity(
                opacity: _opacityController.value,
                child: ClipOval(
                  child: Image.asset(
                    "assets/logo.gif",
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _startAnimation() async {
    await Future.delayed(

        // Delay for a smoother transition
        Duration(milliseconds: 500));

    // Start the opacity animation
    _opacityController.forward(from: 0);

    // Start the rotation animation
    _rotationController.forward();
    setState(() {
      _opacity = 1;
    });
  }
}
