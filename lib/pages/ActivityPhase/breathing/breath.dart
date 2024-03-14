import 'package:flutter/material.dart';
import 'package:relaxio/pages/ActivityPhase/breathing/screens/breath_home_screen.dart';
import 'package:relaxio/pages/ActivityPhase/breathing/utils/constants.dart';

class Breathing extends StatelessWidget {
  const Breathing({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
        primarySwatch: green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
