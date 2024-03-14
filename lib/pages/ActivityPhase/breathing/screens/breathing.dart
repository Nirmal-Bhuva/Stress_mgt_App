import 'package:flutter/material.dart';
import 'package:relaxio/pages/ActivityPhase/breathing/utils/constants.dart';
import 'package:relaxio/pages/ActivityPhase/breathing/widgets/three_stage.dart';
import 'package:relaxio/pages/ActivityPhase/breathing/widgets/two_stage.dart';

class Breathing extends StatelessWidget {
  final String pattern;

  const Breathing({super.key, required this.pattern});

  @override
  Widget build(BuildContext context) {
    StatefulWidget breather;

    switch (pattern) {
      case '7/11 Breathing':
        breather = TwoStage();
        break;
      case '4-7-8 Breathing':
        breather = ThreeStage();
        break;
      default:
        breather = TwoStage();
        break;
    }

    return Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          title: Text(
            pattern,
            style: TextStyle(color: black),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [breather],
                ),
              ),
            ),
          ],
        ));
  }
}
