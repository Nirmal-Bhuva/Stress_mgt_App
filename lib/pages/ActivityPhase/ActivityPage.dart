import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/colors.dart';

class ActivityHome extends StatefulWidget {
  const ActivityHome({super.key});

  @override
  State<ActivityHome> createState() => _ActivityHomeState();
}

class _ActivityHomeState extends State<ActivityHome> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // TOP BAR PANEL
            SizedBox(
              height: screenHeight * 0.015,
            ),
            Row(
              children: [
                // USER PROFILE / MENU
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.03, 0, 0, 0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: screenWidth * 0.135,
                        height: screenHeight * 0.063,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[100],
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                ),

                // USER NAME
                const SizedBox(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Text(
                      'Hemil',
                      style: TextStyle(
                        fontSize: 25,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),

                // LOG BUTTON
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.45, 0, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        //Navigator.push(
                        //context,
                        //MaterialPageRoute(
                        // builder: (context) => const LogScreen()),
                        //);
                      },
                      child: Container(
                        width: screenWidth * 0.135,
                        height: screenHeight * 0.063,
                        decoration: BoxDecoration(
                          color: const Color(0xFFB5E99D),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // BODY --------------------
            SizedBox(
              height: screenHeight * 0.035,
            ),
            Container(
              width: screenWidth * 0.92,
              height: screenHeight * 0.26,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Center(
                child: Text(
                  'Scroll View\n of Quotes',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    letterSpacing: 3,
                  ),
                ),
              ),
            ),

            // CIRCLE POP's
            SizedBox(
              height: screenHeight * 0.035,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.05,
                  ),
                  Container(
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.21,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.05,
                  ),
                  Container(
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.21,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.05,
                  ),
                  Container(
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.21,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.05,
                  ),
                  Container(
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.21,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.05,
                  ),
                  Container(
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.21,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.05,
                  ),
                  Container(
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.21,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.05,
                  ),
                ],
              ),
            ),

            // MUSIC PANEL
            SizedBox(
              height: screenHeight * 0.04,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Music',
                  style: TextStyle(
                    fontSize: 25,
                    letterSpacing: 5,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                  Container(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                  Container(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                  Container(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                  Container(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                  Container(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                  Container(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                ],
              ),
            ),

            // VIDEOs PANEL
            SizedBox(
              height: screenHeight * 0.04,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Video',
                  style: TextStyle(
                    fontSize: 25,
                    letterSpacing: 5,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                  Container(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                  Container(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                  Container(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                  Container(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                  Container(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                  Container(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                ],
              ),
            ),

            // ARTICLES PANEL
            SizedBox(
              height: screenHeight * 0.04,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Articles',
                  style: TextStyle(
                    fontSize: 25,
                    letterSpacing: 5,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                  Container(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                  Container(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                  Container(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                  Container(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                  Container(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                  Container(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
          ],
        ),
      ),
    );
    /*return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // TOP CONTAINER with ACTIVITY TITLE
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Container(
                    width: 250,
                    height: 80,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "ACTIVITY",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 2.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // ACTIVITY PANEL AREA
                const SizedBox(
                  height: 20,
                ),

                // ACTIVITY PANNEL 1
                Row(
                  children: [
                    // ACTVITY 1
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 7, 15),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed('/MusicList');
                          },
                          child: Container(
                            width: 175,
                            height: 210,
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "ACTIVITY 1",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // ACTIVITY 2
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(7, 15, 15, 15),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 175,
                            height: 210,
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "ACTIVITY 2",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // ACTIVITY PANNEL 2
                Row(
                  children: [
                    // ACTIVITY 3
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 7, 15),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 175,
                            height: 210,
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "ACTIVITY 3",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // ACTIVITY 4
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(7, 15, 15, 15),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 175,
                            height: 210,
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "ACTIVITY 4",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // ACTIVITY PANNEL 3
                Row(
                  children: [
                    // ACTIVITY 5
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 7, 15),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 175,
                            height: 210,
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "ACTIVITY 5",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // ACTIVITY 6
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(7, 15, 15, 15),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 175,
                            height: 210,
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "ACTIVITY 6",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // ACTIVITY PANNEL 4
                Row(
                  children: [
                    // ACTIVITY 7
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 7, 15),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 175,
                            height: 210,
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "ACTIVITY 7",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // ACTIVITY 8
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(7, 15, 15, 15),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 175,
                            height: 210,
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "ACTIVITY 8",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );*/
  }
}
