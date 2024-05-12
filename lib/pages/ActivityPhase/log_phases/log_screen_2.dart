import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';
import 'package:relaxio/pages/ActivityPhase/log_phases/log_successfully.dart';
import '../../../themes/colors.dart';

class LogScreen2 extends StatefulWidget {
  const LogScreen2({super.key});

  @override
  State<LogScreen2> createState() => _LogScreen2State();
}

class _LogScreen2State extends State<LogScreen2> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? selectedFeeling;
  bool canPressButton = true;
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  void _storeData(String userEmail, String feeling) async {
    try {
      DocumentReference logRef = _firestore.collection('log').doc(userEmail);

      // Get the current timestamp
      Timestamp timestamp = Timestamp.now();
      final now = DateTime.now();

      // Create a map with feeling and timestamp
      // Create a map with feeling and timestamp
      Map<String, dynamic> feelingData = {
        currentDate: {
          "impact": feeling,
          // "currentDate": now,
          // "timestamp": timestamp,
        },
      };
      // Update the document with the new feeling and timestamp
      await logRef.set(feelingData, SetOptions(merge: true));

      print('Feeling and timestamp appended successfully!');
    } catch (e) {
      print('Error storing data: $e');
    }
  }

  Future<void> _handleButtonPress(String feeling) async {
    if (!canPressButton) {
      // User can't press the button yet, show a message or handle accordingly
      return;
    }

    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        canPressButton = false; // Disable button press
        selectedFeeling = feeling;
      });

      _storeData(user.email!, feeling);

      // Set a timer to enable button after 24 hours
      Future.delayed(const Duration(seconds: 10), () {
        setState(() {
          canPressButton = true; // Enable button after 24 hours
        });
      });
    } else {
      // User is not logged in, handle the situation accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          // TOP TITLE
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: const Column(
                children: [
                  Text(
                    'What\'s having biggest impact on you ?',
                    style: TextStyle(
                      fontSize: 25,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // PANEL TO SELECT THE OPTIONS
          SizedBox(
            height: screenHeight * 0.04,
          ),
          Container(
            height: screenHeight * 0.75,
            width: screenWidth * 0.95,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(45),
            ),
            child: Column(
              children: [
                // TELL US MORE TEXT
                SizedBox(
                  height: screenHeight * 0.06,
                ),
                Text(
                  'Tell us a little more about that .',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                  ),
                ),

                // SELECTION OF OPTIONS
                // ROW - 1
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 35, horizontal: 19),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _handleButtonPress('Health'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                              child: Text(
                            'Health',
                            style: TextStyle(fontSize: 18),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      GestureDetector(
                        onTap: () => _handleButtonPress('Fitness'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                              child: Text(
                            'Fitness',
                            style: TextStyle(fontSize: 18),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      GestureDetector(
                        onTap: () => _handleButtonPress('Spirituality'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                              child: Text(
                            'Spirituality',
                            style: TextStyle(fontSize: 18),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),

                // ROW - 2
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Row(
                    children: [
                      SizedBox(
                        width: screenWidth * 0.14,
                      ),
                      GestureDetector(
                        onTap: () => _handleButtonPress('Hobby'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Text(
                              'Hobby',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.08,
                      ),
                      GestureDetector(
                        onTap: () => _handleButtonPress('Identity'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Text(
                              'Identity',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ROW - 3
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 35, horizontal: 19),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _handleButtonPress('Community'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                              child: Text(
                            'Community',
                            style: TextStyle(fontSize: 18),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      GestureDetector(
                        onTap: () => _handleButtonPress('Family'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                              child: Text(
                            'Family',
                            style: TextStyle(fontSize: 18),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      GestureDetector(
                        onTap: () => _handleButtonPress('Friends'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                              child: Text(
                            'Friends',
                            style: TextStyle(fontSize: 18),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),

                // ROW - 4
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Row(
                    children: [
                      SizedBox(
                        width: screenWidth * 0.14,
                      ),
                      GestureDetector(
                        onTap: () => _handleButtonPress('Partner'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Text(
                              'Partner',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.08,
                      ),
                      GestureDetector(
                        onTap: () => _handleButtonPress('Dating'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Text(
                              'Dating',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ROW - 5
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 35, horizontal: 19),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _handleButtonPress('Work'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                              child: Text(
                            'Work',
                            style: TextStyle(fontSize: 18),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      GestureDetector(
                        onTap: () => _handleButtonPress('Education'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                              child: Text(
                            'Education',
                            style: TextStyle(fontSize: 18),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      GestureDetector(
                        onTap: () => _handleButtonPress('Money'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                              child: Text(
                            'Money',
                            style: TextStyle(fontSize: 18),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: screenHeight * 0.03,
                ),
                SizedBox(
                  width: screenWidth * 0.35,
                  height: screenHeight * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/logSuccessfully');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC9F3B5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: const Text(
                      'DONE',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        letterSpacing: 6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
