import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relaxio/themes/colors.dart';
import 'package:relaxio/utils/utils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool loading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // TOP CONTAINER with TEXT
              Container(
                width: double.infinity,
                height: screenHeight * 0.13,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(70.0),
                    bottomRight: Radius.circular(70.0),
                  ),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Let Relaxio be your escape from the chaos of life.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 3.5,
                      ),
                    ),
                  ),
                ),
              ),

              // FORGOT PASSWORD CONTAINER
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Container(
                width: screenWidth * 0.92,
                height: screenHeight * 0.58,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "FORGOT",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            letterSpacing: 6,
                          ),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "PASSWORD",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            letterSpacing: 6,
                          ),
                        ),
                      ),

                      // EMAIL FIELD
                      SizedBox(
                        height: screenHeight * 0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: 'EMAIL',
                            hintStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              letterSpacing: 7,
                            ),
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                screenHeight * 0.025,
                              ),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                screenHeight * 0.025,
                              ),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),
                          ),
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter email';
                            }
                            return null;
                          },
                        ),
                      ),

                      // RESET BUTTON
                      SizedBox(height: screenHeight * 0.095),
                      SizedBox(
                        width: screenWidth * 0.55,
                        height: screenHeight * 0.09,
                        child: ElevatedButton(
                          onPressed: () {
                            _auth
                                .sendPasswordResetEmail(
                                    email: emailController.text.toString())
                                .then((value) {
                              Utils().toastMessage(
                                  "We have sent you email to recover password , please check email");
                            }).onError((error, StackTrace) {
                              Utils().toastMessage(error.toString());
                            });
                            // Add your logic for password reset here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC9F3B5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                screenHeight * 0.025,
                              ),
                            ),
                          ),
                          child: loading
                              ? CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Colors.white,
                                )
                              : Text(
                                  'RESET',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    letterSpacing: 6,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // BACK TO LOGIN BUTTON / CONTAINER at BOTTOM
              SizedBox(height: screenHeight * 0.135),
              SizedBox(
                width: screenWidth * 0.7,
                height: screenHeight * 0.065,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/LogMove');
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );*/
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7EB9E9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        screenHeight * 0.04,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Back to LOGIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 7,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:relaxioui/pages/loginPhase/login.dart';
// import 'package:relaxioui/themes/colors.dart';
//
// class ForgotPassword extends StatefulWidget {
//   const ForgotPassword({Key? key}) : super(key: key);
//
//   @override
//   State<ForgotPassword> createState() => _ForgotPasswordState();
// }
//
// class _ForgotPasswordState extends State<ForgotPassword> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColor,
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: [
//
//               // TOP CONTAINER with TEXT
//               Container(
//                 width: 400,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   color: secondaryColor,
//                   borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(70.0),
//                     bottomRight: Radius.circular(70.0),
//                   ),
//                 ),
//                 child: const Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(20.0),
//                     child: Text(
//                       "Let Relaxio be your escape from the chaos of life.",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         letterSpacing: 3.5,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//               // FORGOT PASSWORD CONTAINER
//               const SizedBox(
//                 height: 40,
//               ),
//               Container(
//                 width: 360,
//                 height: 440,
//                 decoration: BoxDecoration(
//                   color: secondaryColor,
//                   borderRadius: BorderRadius.circular(45),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Column(
//                     children: [
//                       const Align(
//                         alignment: Alignment.topCenter,
//                         child: Text(
//                           "FORGOT",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 25,
//                             letterSpacing: 6,
//                           ),
//                         ),
//                       ),
//                       const Align(
//                         alignment: Alignment.topCenter,
//                         child: Text(
//                           "PASSWORD",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 25,
//                             letterSpacing: 6,
//                           ),
//                         ),
//                       ),
//
//                       // EMAIL FIELD
//                       const SizedBox(
//                         height: 75,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                         child: TextFormField(
//                           textInputAction: TextInputAction.next,
//                           keyboardType: TextInputType.emailAddress,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.grey[200],
//                             hintText: 'EMAIL',
//                             hintStyle: const TextStyle(
//                               color: Colors.black,
//                               letterSpacing: 7,
//                             ),
//                             alignLabelWithHint: true,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25.0),
//                               borderSide: BorderSide(color: Colors.blue),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25.0),
//                               borderSide: BorderSide(color: Colors.blue),
//                             ),
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//
//                       // RESET BUTTON
//                       const SizedBox(height: 75),
//                       SizedBox(
//                         width: 230,
//                         height: 70,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             // Add your logic for password reset here
//                           },
//                           style: ElevatedButton.styleFrom(
//                             primary: const Color(0xFFC9F3B5),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(25.0),
//                             ),
//                           ),
//                           child: const Text(
//                             'RESET',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 20,
//                               letterSpacing: 6,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // BACK TO LOGIN BUTTON / CONTAINER at BOTTOM
//               const SizedBox(height: 115),
//               SizedBox(
//                 width: 320,
//                 height: 65,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const Login()),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: const Color(0xFF7EB9E9),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(40.0),
//                     ),
//                   ),
//                   child: const Text(
//                     'Back to LOGIN',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       letterSpacing: 7,
//                       fontWeight: FontWeight.w300,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }