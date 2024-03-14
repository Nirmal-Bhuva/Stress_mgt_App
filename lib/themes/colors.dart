import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// var primaryColor = Colors.white;
// var secondaryColor = const Color(0xFF7EB9E9);

var primaryColor = const Color(0xFFFFFFFF);
var secondaryColor = const Color(0xFF7EB9E9);

// var primaryColor = const Color(0xFFFFFFFF);
// var secondaryColor = const Color(0xFFA39BCF);

class Power {
  static const Color background = Color(0xff8e97fd);

//for journal
  static Color bgColor = Color(0xFFe2e2fe);

  static List<Color> cardsColor = [
    Colors.white,
    Colors.red.shade100,
    Colors.pink.shade100,
    Colors.orange.shade100,
    Colors.yellow.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.blueGrey.shade100
  ];

  static TextStyle mainTitle =
      GoogleFonts.roboto(fontSize: 18.0, fontWeight: FontWeight.bold);

  static TextStyle mainContent =
      GoogleFonts.roboto(fontSize: 18.0, fontWeight: FontWeight.normal);

  static TextStyle dateTitle =
      GoogleFonts.roboto(fontSize: 13.0, fontWeight: FontWeight.w500);
}
