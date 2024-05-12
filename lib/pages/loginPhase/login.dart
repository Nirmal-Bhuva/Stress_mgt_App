import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relaxio/components/button.dart';
import 'package:relaxio/themes/colors.dart';
import 'package:relaxio/utils/utils.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  var username;
  var password;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
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
              Container(
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

              // LOGIN CONTAINER
              SizedBox(height: screenHeight * 0.05),
              Container(
                width: screenWidth * 0.92,
                height: screenHeight * 0.58,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            letterSpacing: 6,
                          ),
                        ),
                      ),

                      // USERNAME FIELD
                      SizedBox(height: screenHeight * 0.06),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            screenWidth * 0.05, 0, screenWidth * 0.05, 0),
                        child: TextFormField(
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'USERNAME',
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
                                return 'Enter your name';
                              } else {
                                return null;
                              }
                            }),
                      ),

                      // PASSWORD FIELD
                      SizedBox(height: screenHeight * 0.05),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            screenWidth * 0.05, 0, screenWidth * 0.05, 0),
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
                      SizedBox(height: screenHeight * 0.08),
                      SizedBox(
                        width: screenWidth *
                            0.6, // Adjust your desired button width
                        height: screenHeight *
                            0.1, // Adjust your desired button height
                        child: ElevatedButton(
                          onPressed: () {
                            login();
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

              // FORGOT PASSWORD
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed('/ForgetPass');
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPassword()),
                      );*/
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          screenWidth * 0.1, 0, screenWidth * 0.1, 0),
                      child: const Text(
                        'FORGOT PASSWORD',
                        style: TextStyle(
                          color: Colors.indigoAccent,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          letterSpacing: 3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // SIGNUP BUTTON / CONTAINER at BOTTOM
              SizedBox(height: screenHeight * 0.075),
              MyButton(
                  text: "SIGNUP",
                  onTap: () {
                    /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUp()),*/
                    Get.toNamed('/SignupScreen');
                  }),
            ],
          ),
        ),
      ),
    );
  }

/*
  Future<void> login_serve() async {
    setState(() {
      loading = true;
    });
    
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: userController)
        .get();
    currentContext
  }
}*/

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString())
        .then((value) {
      Utils().toastMessage(value.user!.email.toString());
      Get.toNamed('/Home');
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }
}
// import 'package:flutter/material.dart';
// import 'package:relaxioui/components/button.dart';
// import 'package:relaxioui/pages/loginPhase/forgotpass.dart';
// import 'package:relaxioui/pages/loginPhase/intro.dart';
// import 'package:relaxioui/pages/loginPhase/signup.dart';
// import 'package:relaxioui/pages/loginPhase/user.dart';
// import 'package:relaxioui/themes/colors.dart';
//
// class Login extends StatefulWidget {
//   const Login({super.key});
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColor,
//       // ADD SafeArea here.
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
//               // LOGIN CONTAINER
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
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     children: [
//                       const Align(
//                         alignment: Alignment.topCenter,
//                         child: Text(
//                           "LOGIN",
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
//                         height: 55,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
//                         child: TextFormField(
//                           textInputAction: TextInputAction.next,
//                           keyboardType: TextInputType.name,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.grey[200],
//                             hintText: 'USERNAME',
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
//                       const SizedBox(height: 55),
//                       SizedBox(
//                         width: 230, // Set your desired button width
//                         height: 70, // Set your desired button height
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => const User()),
//                             );
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
//               // FORGOT PASSWORD
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const ForgotPassword()),
//                       );
//                     },
//                     child: const Padding(
//                       padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
//                       child: Text(
//                         'FORGOT PASSWORD',
//                         style: TextStyle(
//                           color: Colors.indigoAccent,
//                           fontWeight: FontWeight.normal,
//                           fontSize: 15,
//                           letterSpacing: 3,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//               // SIGNUP BUTTON / CONTAINER at BOTTOM
//               const SizedBox(height: 80,),
//               MyButton(text: "SIGNUP", onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const SignUp()),
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }