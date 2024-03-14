import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relaxio/themes/colors.dart';
import 'package:relaxio/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  //final confirmPassController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    passwordController.dispose();

    super.dispose();
  }

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
              Form(
                key: _formKey,
                child: Container(
                  width: screenWidth,
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
              ),

              // SIGNUP CONTAINER
              SizedBox(height: screenHeight * 0.03),
              Container(
                width: screenWidth * 0.92,
                height: screenHeight * 0.7,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      screenWidth * 0.05, 20, screenWidth * 0.05, 0),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "SIGNUP",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            letterSpacing: 6,
                          ),
                        ),
                      ),

                      // USERNAME FIELD
                      SizedBox(height: screenHeight * 0.05),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            screenWidth * 0.05, 0, screenWidth * 0.05, 0),
                        child: TextFormField(
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: 'USERNAME',
                            hintStyle: const TextStyle(
                              color: Colors.black,
                              letterSpacing: 2,
                            ),
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),
                          ),
                          textAlign: TextAlign.center,
                          validator: (pass) {
                            if (pass!.isEmpty) {
                              return 'Enter your Name';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),

                      // EMAIL FIELD
                      SizedBox(height: screenHeight * 0.03),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            screenWidth * 0.05, 0, screenWidth * 0.05, 0),
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
                                letterSpacing: 2,
                              ),
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            textAlign: TextAlign.center,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (pass) {
                              if (pass!.isEmpty) {
                                return 'Enter your Email';
                              } else {
                                return null;
                              }
                            }),
                      ),

                      // NUMBER FIELD
                      SizedBox(height: screenHeight * 0.03),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            screenWidth * 0.05, 0, screenWidth * 0.05, 0),
                        child: TextFormField(
                            controller: mobileController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'NUMBER',
                              hintStyle: const TextStyle(
                                color: Colors.black,
                                letterSpacing: 2,
                              ),
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            textAlign: TextAlign.center,
                            validator: (pass) {
                              if (pass!.isEmpty) {
                                return 'Enter your number';
                              } else {
                                return null;
                              }
                            }),
                      ),

                      // PASSWORD FIELD
                      SizedBox(height: screenHeight * 0.03),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            screenWidth * 0.03, 0, screenWidth * 0.03, 0),
                        child: TextFormField(
                            controller: passwordController,
                            textInputAction: TextInputAction.next,
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'PASSWORD',
                              hintStyle: const TextStyle(
                                  color: Colors.black, letterSpacing: 2),
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            textAlign: TextAlign.center,
                            validator: (pass) {
                              if (pass!.isEmpty) {
                                return 'Enter your password';
                              } else {
                                return null;
                              }
                            }),
                      ),

                      // ENTER BUTTON
                      SizedBox(height: screenHeight * 0.04),
                      SizedBox(
                        width: screenWidth * 0.5,
                        height: screenHeight * 0.1,
                        child: ElevatedButton(
                          onPressed: () {
                            signUp();
                            // Add your signup logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC9F3B5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          child: loading
                              ? CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Colors.white,
                                )
                              : Text(
                                  'ENTER',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    letterSpacing: 6,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // BACK TO LOGIN BUTTON / CONTAINER at BOTTOM
              SizedBox(height: screenHeight * 0.04),
              SizedBox(
                width: screenWidth * 0.8,
                height: screenHeight * 0.08,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/LogMove');
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );*/
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7EB9E9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                  ),
                  child: const Text(
                    'Back to LOGIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 5,
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

  void signUp() {
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((authResult) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user?.uid)
          .set({
        'name': nameController.text.toString(),
        'email': emailController.text.toString(),
        'mobile': mobileController.text.toString(),
        'password': passwordController.text.toString()

        // You may want to store additional user information here
      }).then((value) {
        Get.toNamed('/Users');

        setState(() {
          loading = false;
        });
      }).onError((error, stackTrace) {
        Utils().toastMessage(error.toString());
        setState(() {
          loading = false;
        });
      });
    }).catchError((error) {
      // Handle Firebase Authentication error
      Utils().toastMessage("Error creating user: $error");
      setState(() {
        loading = false;
      });
    });
  }
}
/*
  void signUp() {
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((authResult) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user?.uid)
          .get()
          .then((userDoc) {
        if (userDoc.exists) {
          // User has already signed up before, navigate to '/hh'
          Get.toNamed('/LogMove');
        } else {
          FirebaseFirestore.instance
              .collection('users')
              .doc(authResult.user?.uid)
              .set({
            'name': nameController.text.toString(),
            'email': emailController.text.toString(),
            'mobile': mobileController.text.toString(),
            'password': passwordController.text.toString()

            // You may want to store additional user information here
          }).then((value) {
            Get.toNamed('/Users');
          }).catchError((error) {
            Utils().toastMessage(error.toString());
          });
        }

        setState(() {
          loading = false;
        });
      }).onError((error, stackTrace) {
        Utils().toastMessage(error.toString());
        setState(() {
          loading = false;
        });
      });
    }).catchError((error) {
      // Handle Firebase Authentication error
      Utils().toastMessage("Error creating user: $error");
      setState(() {
        loading = false;
      });
    });
  }
}
*/

// import 'package:flutter/material.dart';
// import 'package:relaxioui/pages/loginPhase/login.dart';
// import 'package:relaxioui/themes/colors.dart';
//
// class SignUp extends StatefulWidget {
//   const SignUp({Key? key}) : super(key: key);
//
//   @override
//   State<SignUp> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
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
//               // SIGNUP CONTAINER
//               const SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 width: 360,
//                 height: 550,
//                 decoration: BoxDecoration(
//                   color: secondaryColor,
//                   borderRadius: BorderRadius.circular(45),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
//                   child: Column(
//                     children: [
//                       const Align(
//                         alignment: Alignment.topCenter,
//                         child: Text(
//                           "SIGNUP",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 30,
//                             letterSpacing: 6,
//                           ),
//                         ),
//                       ),
//
//                       // USERNAME FIELD
//                       const SizedBox(
//                         height: 35,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                         child: TextFormField(
//                           textInputAction: TextInputAction.next,
//                           keyboardType: TextInputType.name,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.grey[200],
//                             hintText: 'USERNAME',
//                             hintStyle: const TextStyle(
//                               color: Colors.black,
//                               letterSpacing: 7,
//                             ),
//                             alignLabelWithHint: true,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25.0),
//                               borderSide: const BorderSide(color: Colors.blue),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25.0),
//                               borderSide: const BorderSide(color: Colors.blue),
//                             ),
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//
//                       // EMAIL FIELD
//                       const SizedBox(
//                         height: 20,
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
//                       // NUMBER FIELD
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                         child: TextFormField(
//                           textInputAction: TextInputAction.next,
//                           keyboardType: TextInputType.phone,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.grey[200],
//                             hintText: 'NUMBER',
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
//                       // PASSWORD FIELD
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
//                         child: TextFormField(
//                           textInputAction: TextInputAction.next,
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.grey[200],
//                             hintText: 'PASSWORD',
//                             hintStyle: const TextStyle(
//                                 color: Colors.black, letterSpacing: 7),
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
//                       // ENTER BUTTON
//                       const SizedBox(height: 45),
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
//                             'ENTER',
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
//               const SizedBox(height: 25),
//               // const SizedBox(height: 55),
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