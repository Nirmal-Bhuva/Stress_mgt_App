import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:relaxio/pages/ActivityPhase/log_phases/log_screen_2.dart';
import 'package:relaxio/themes/colors.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({Key? key}) : super(key: key);

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
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
          "feeling": feeling,
          "currentDate": currentDate,
          "timestamp": timestamp,
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
            height: screenHeight * 0.06,
          ),
          const Center(
            child: Text(
              'How are you Feeling ?',
              style: TextStyle(
                fontSize: 27,
                letterSpacing: 3,
              ),
            ),
          ),

          // PANEL TO SELECT THE OPTIONS
          SizedBox(
            height: screenHeight * 0.055,
          ),

          // MAIN BLUE CONTAINER
          Container(
            height: screenHeight * 0.75,
            width: screenWidth * 0.95,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(45),
            ),
            child: Column(
              children: [
                // EMOJI'S CIRCLES
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
                //   child: Row(
                //     children: [
                //       SizedBox(
                //         width: screenWidth * 0.035,
                //       ),
                //       GestureDetector(
                //         onTap: () {},
                //         child: Container(
                //           height: screenHeight * 0.06,
                //           width: screenWidth * 0.13,
                //           decoration: BoxDecoration(
                //             color: Colors.grey,
                //             borderRadius: BorderRadius.circular(50),
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         width: screenWidth * 0.042,
                //       ),
                //       GestureDetector(
                //         onTap: () {},
                //         child: Container(
                //           height: screenHeight * 0.06,
                //           width: screenWidth * 0.13,
                //           decoration: BoxDecoration(
                //             color: Colors.grey,
                //             borderRadius: BorderRadius.circular(50),
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         width: screenWidth * 0.042,
                //       ),
                //       GestureDetector(
                //         onTap: () {},
                //         child: Container(
                //           height: screenHeight * 0.06,
                //           width: screenWidth * 0.13,
                //           decoration: BoxDecoration(
                //             color: Colors.grey,
                //             borderRadius: BorderRadius.circular(50),
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         width: screenWidth * 0.042,
                //       ),
                //       GestureDetector(
                //         onTap: () {},
                //         child: Container(
                //           height: screenHeight * 0.06,
                //           width: screenWidth * 0.13,
                //           decoration: BoxDecoration(
                //             color: Colors.grey,
                //             borderRadius: BorderRadius.circular(50),
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         width: screenWidth * 0.042,
                //       ),
                //       GestureDetector(
                //         onTap: () {},
                //         child: Container(
                //           height: screenHeight * 0.06,
                //           width: screenWidth * 0.13,
                //           decoration: BoxDecoration(
                //             color: Colors.grey,
                //             borderRadius: BorderRadius.circular(50),
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         width: screenWidth * 0.035,
                //       ),
                //     ],
                //   ),
                // ),

                // TEXT OF DESCRIBING FEELINGS
                SizedBox(
                  height: screenHeight * 0.010,
                ),
                Text(
                  'What describes the Best Feeling\'s ?',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                  ),
                ),

                // SELECTION OF OPTIONS
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 35, horizontal: 19),
                  child: Row(
                    children: [
                      GestureDetector(
                        //onTap: () => _handleButtonPress('Happy'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {
                                // Handle button tap here
                                _handleButtonPress('Happy');
                              },
                              child: Center(
                                child: Text(
                                  'Happy',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      GestureDetector(
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {
                                // Handle button tap here
                                _handleButtonPress('Proud');
                              },
                              child: Center(
                                child: Text(
                                  'Proud',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      GestureDetector(
                        onTap: () => _handleButtonPress('Excited'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                              child: Text(
                            'Excited',
                            style: TextStyle(fontSize: 18),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Row(
                    children: [
                      SizedBox(
                        width: screenWidth * 0.15,
                      ),
                      GestureDetector(
                        onTap: () => _handleButtonPress('Calm'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Text(
                              'Calm',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.08,
                      ),
                      GestureDetector(
                        onTap: () => _handleButtonPress('Relieved'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Text(
                              'Relieved',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // SELECTION OF OPTIONS 2
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 35, horizontal: 19),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _handleButtonPress('Angry'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                              child: Text(
                            'Angry',
                            style: TextStyle(fontSize: 18),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      GestureDetector(
                        onTap: () => _handleButtonPress('Sad'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                              child: Text(
                            'Sad',
                            style: TextStyle(fontSize: 18),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      GestureDetector(
                        onTap: () => _handleButtonPress('Scared'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                              child: Text(
                            'Scared',
                            style: TextStyle(fontSize: 18),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Row(
                    children: [
                      SizedBox(
                        width: screenWidth * 0.15,
                      ),
                      GestureDetector(
                        onTap: () => _handleButtonPress('Guilty'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Text(
                              'Guilty',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.08,
                      ),
                      GestureDetector(
                        onTap: () => _handleButtonPress('Frustrated'),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Text(
                              'Frustrated',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // NEXT BUTTON
                SizedBox(
                  height: screenHeight * 0.08,
                ),
                SizedBox(
                  width: screenWidth * 0.35,
                  height: screenHeight * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LogScreen2()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC9F3B5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: const Text(
                      'NEXT',
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
