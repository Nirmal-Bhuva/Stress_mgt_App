import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Timer(
        const Duration(seconds: 3),
        () => Get.toNamed('/Home'),
      );
    } else {
      Timer(
        const Duration(seconds: 3),
        () => Get.toNamed('/LogMove'),
      );
    }
  }
}
