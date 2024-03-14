import 'package:flutter/material.dart';
import 'package:relaxio/pages/ActivityPhase/breathing/widgets/breather.dart';

class TwoStage extends StatefulWidget {
  const TwoStage({super.key});

  @override
  State<TwoStage> createState() => _TwoStageState();
}

class _TwoStageState extends State<TwoStage> with TickerProviderStateMixin {
  late AnimationController _breathingController;
  late String _action;

  @override
  void initState() {
    super.initState();
    _action = 'Breathe In';
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1750),
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _breathingController.duration = const Duration(milliseconds: 2750);
          _action = 'Breathe Out';
          _breathingController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _action = 'Breathe In';
          _breathingController.forward();
        }
      })
      ..addListener(() {
        setState(() {});
      });
    _breathingController.forward();
  }

  @override
  void dispose() {
    _breathingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Breather(breathingController: _breathingController, action: _action);
  }
}
