import 'package:flutter/material.dart';
import 'package:relaxio/pages/ActivityPhase/journal/screens/home_page.dart';
import 'package:relaxio/pages/ActivityPhase/journal/theme/colors.dart';

class JournalHome extends StatelessWidget {
  const JournalHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primarySwatch: primaryColor, brightness: Brightness.dark),
      home: HomePage(),
    );
  }
}
