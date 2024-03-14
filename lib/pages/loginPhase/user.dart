import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:relaxio/themes/colors.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  bool loading = false;
  final bdate = TextEditingController();
  final gender = TextEditingController();
  final weight = TextEditingController();
  final height = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            child: Column(
              children: [
                // TOP CONTAINER with TEXT
                SizedBox(height: screenHeight * 0.03),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: screenWidth * 0.92,
                    height: screenHeight * 0.1,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "Welcome Hemil",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 3.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // USER DATA CONTAINER
                SizedBox(height: screenHeight * 0.005),
                Container(
                  width: screenWidth * 0.92,
                  height: screenHeight * 0.65,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Tell us more",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              letterSpacing: 3,
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "about yourself !!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              letterSpacing: 3,
                            ),
                          ),
                        ),

                        // BIRTHDATE SELECTOR
                        SizedBox(height: screenHeight * 0.04),
                        GestureDetector(
                          onTap: () async {
                            DateTime? pickedate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );

                            if (pickedate != null) {
                              setState(() {
                                bdate.text =
                                    DateFormat("dd-MM-yyyy").format(pickedate);
                              });
                            }
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              controller: bdate,
                              enabled: false,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintText: 'BIRTHDATE',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 1.5,
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
                                  return 'Enter your birthdate';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),

                        // GENDER SELECTION
                        SizedBox(height: screenHeight * 0.03),
                        GestureDetector(
                          onTap: () async {
                            // Show the gender menu
                            showGenderMenu(context);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              controller: gender,
                              enabled: false,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintText: 'GENDER',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 1.5,
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Select your gender';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.03),
                        GestureDetector(
                          onTap: () async {
                            // Show the weight picker
                            showWeightPicker(context);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              controller: weight,
                              enabled: false,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintText: 'WEIGHT',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 1.5,
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter your weight';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),

                        // HEIGHT SELECTION
                        SizedBox(height: screenHeight * 0.02),
                        GestureDetector(
                          onTap: () async {
                            // Show the weight picker
                            showHeightPicker(context);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              controller: height,
                              enabled: false,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintText: 'HEIGHT',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 1.5,
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter your height';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),

                        // ENTER BUTTON
                        SizedBox(height: screenHeight * 0.025),
                        SizedBox(
                          width: screenWidth * 0.51,
                          height: screenHeight * 0.1,
                          child: ElevatedButton(
                            onPressed: () {
                              extra();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFC9F3B5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            child: const Text(
                              'ENTER',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // BOTTOM CONTAINER with QUOTE's
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: screenWidth * 0.92,
                    height: screenHeight * 0.13,
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "Stress is like a rocking chair. It gives you something to do but gets you nowhere.",
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      // Update the TextFormField with the selected date
      // You can format the date as needed, for example: dd/MM/yyyy
      String formattedDate =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";

      // You can use the formattedDate as needed (e.g., update the TextFormField)
      print('Selected date: $formattedDate');
    }
  }

  void showGenderMenu(BuildContext context) async {
    String? selectedGender = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(150, 380, 150, 0),
      items: [
        PopupMenuItem(
          child: Text('MALE'),
          value: 'MALE',
        ),
        PopupMenuItem(
          child: Text('FEMALE'),
          value: 'FEMALE',
        ),
        PopupMenuItem(
          child: Text('OTHERS'),
          value: 'OTHERS',
        ),
      ],
    );

    if (selectedGender != null) {
      setState(() {
        // Update the gender text field
        gender.text = selectedGender;
      });
    }
  }

  void showWeightPicker(BuildContext context) async {
    int? selectedWeight = await showMenu<int>(
      context: context,
      position: RelativeRect.fromLTRB(150, 470, 150, 0),
      items: [
        PopupMenuItem(
          child: Text('50 kg'),
          value: 50,
        ),
        PopupMenuItem(
          child: Text('60 kg'),
          value: 60,
        ),
        PopupMenuItem(
          child: Text('70 kg'),
          value: 70,
        ),
        // Add more weights as needed
      ],
    );

    if (selectedWeight != null) {
      setState(() {
        // Update the weight text field
        weight.text = '$selectedWeight kg';
      });
    }
  }

  void showHeightPicker(BuildContext context) async {
    int? selectedHeight = await showMenu<int>(
      context: context,
      position: RelativeRect.fromLTRB(150, 470, 150, 0),
      items: [
        PopupMenuItem(
          child: Text('5\'0'),
          value: 5,
        ),
        PopupMenuItem(
          child: Text('5\'5'),
          value: 55,
        ),
        PopupMenuItem(
          child: Text('6\'0'),
          value: 6,
        ),
        PopupMenuItem(
          child: Text('6\'5'),
          value: 65,
        ),
        PopupMenuItem(
          child: Text('7\'0'),
          value: 7,
        ),
        // Add more weights as needed
      ],
    );

    if (selectedHeight != null) {
      setState(() {
        // Update the weight text field
        height.text = '$selectedHeight';
      });
    }
  }

  void extra() {
    setState(() {
      loading = true;
    });

    if (_auth.currentUser != null) {
      String userEmail = _auth.currentUser!.email.toString();

      FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          String documentId = querySnapshot.docs[0].id;

          FirebaseFirestore.instance
              .collection('users')
              .doc(documentId)
              .update({
            'birthdate': bdate.text.toString(),
            'gender': gender.text.toString(),
            'weight': weight.text.toString(),
            'height': height.text.toString(),
          }).then((value) {
            Get.toNamed('/LogMove');

            print('Document updated successfully!');
            setState(() {
              loading = false;
            });
          }).catchError((error) {
            print('Error updating document: $error');
            setState(() {
              loading = false;
            });
          });
        } else {
          print('No document found with the logged-in user\'s email.');
          setState(() {
            loading = false;
          });
        }
      }).catchError((error) {
        print('Error querying documents: $error');
        setState(() {
          loading = false;
        });
      });
    } else {
      print('User is not logged in.');
      // Handle the case where the user is not logged in
      setState(() {
        loading = false;
      });
    }
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
          .set({
        'name': nameController.text.toString(),
        'email': emailController.text.toString(),
        'mobile': mobileController.text.toString(),
        'password': passwordController.text.toString()

        // You may want to store additional user information here
      }).then((value) {
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
  }*/



// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:relaxioui/themes/colors.dart';
//
// class User extends StatefulWidget {
//   const User({super.key});
//
//   @override
//   State<User> createState() => _UserState();
// }
//
// class _UserState extends State<User> {
//
//   final bdate = TextEditingController();
//   final gender = TextEditingController();
//   final weight = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Center(
//             child: Form(
//               child: Column(
//                 children: [
//
//
//                   // TOP CONTAINER with TEXT
//                   const SizedBox(height: 5,),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Container(
//                       width: 400,
//                       height: 100,
//                       decoration: BoxDecoration(
//                           color: secondaryColor,
//                           borderRadius: const BorderRadius.all(Radius.circular(40))),
//                       child: const Center(
//                         child: Padding(
//                           padding: EdgeInsets.all(20.0),
//                           child: Text(
//                             "Welcome Hemil",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 25,
//                               fontWeight: FontWeight.w400,
//                               letterSpacing: 3.5,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   // USER DATA CONTAINER
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   Container(
//                     width: 360,
//                     height: 480,
//                     decoration: BoxDecoration(
//                       color: secondaryColor,
//                       borderRadius: BorderRadius.circular(45),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Column(
//                         children: [
//                           const Align(
//                             alignment: Alignment.topCenter,
//                             child: Text(
//                               "Tell us more",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 25,
//                                 letterSpacing: 6,
//                               ),
//                             ),
//                           ),
//                           const Align(
//                             alignment: Alignment.topCenter,
//                             child: Text(
//                               "about yourself !!",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 25,
//                                 letterSpacing: 6,
//                               ),
//                             ),
//                           ),
//
//                           // BIRTHDATE SELECTOR
//                           const SizedBox(
//                             height: 25,
//                           ),
//                           GestureDetector(
//                             onTap: () async {
//                               DateTime? pickedate = await showDatePicker(
//                                   context: context,
//                                   initialDate: DateTime.now(),
//                                   firstDate: DateTime(1900),
//                                   lastDate: DateTime.now());
//
//                               if (pickedate != null) {
//                                 setState(() {
//                                   bdate.text = DateFormat("dd-MM-yyyy").format(pickedate);
//                                 });
//                               }
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                               child: TextFormField(
//                                 controller: bdate,
//                                 enabled: false,
//                                 textInputAction: TextInputAction.next,
//                                 decoration: InputDecoration(
//                                   filled: true,
//                                   fillColor: Colors.grey[200],
//                                   hintText: 'BIRTHDATE',
//                                   hintStyle: const TextStyle(
//                                     color: Colors.black,
//                                     letterSpacing: 7,
//                                   ),
//                                   alignLabelWithHint: true,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(25.0),
//                                     borderSide: BorderSide(color: Colors.blue),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(25.0),
//                                     borderSide: BorderSide(color: Colors.blue),
//                                   ),
//                                 ),
//                                 textAlign: TextAlign.center,
//                                 validator: (pass) {
//                                   if (pass!.isEmpty) {
//                                     return 'Enter your birthdate';
//                                   } else {
//                                     return null;
//                                   }
//                                 },
//                               ),
//                             ),
//                           ),
//
//                           // GENDER SELECTION
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           GestureDetector(
//                             onTap: () async {
//                               // Show the gender menu
//                               showGenderMenu(context);
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                               child: TextFormField(
//                                 controller: gender,
//                                 enabled: false,
//                                 textInputAction: TextInputAction.next,
//                                 decoration: InputDecoration(
//                                   filled: true,
//                                   fillColor: Colors.grey[200],
//                                   hintText: 'GENDER',
//                                   hintStyle: const TextStyle(
//                                     color: Colors.black,
//                                     letterSpacing: 7,
//                                   ),
//                                   alignLabelWithHint: true,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(25.0),
//                                     borderSide: BorderSide(color: Colors.blue),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(25.0),
//                                     borderSide: BorderSide(color: Colors.blue),
//                                   ),
//                                 ),
//                                 textAlign: TextAlign.center,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'Select your gender';
//                                   } else {
//                                     return null;
//                                   }
//                                 },
//                               ),
//                             ),
//                           ),
//
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           GestureDetector(
//                             onTap: () async {
//                               // Show the weight picker
//                               showWeightPicker(context);
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                               child: TextFormField(
//                                 controller: weight,
//                                 enabled: false,
//                                 textInputAction: TextInputAction.next,
//                                 decoration: InputDecoration(
//                                   filled: true,
//                                   fillColor: Colors.grey[200],
//                                   hintText: 'WEIGHT',
//                                   hintStyle: const TextStyle(
//                                     color: Colors.black,
//                                     letterSpacing: 7,
//                                   ),
//                                   alignLabelWithHint: true,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(25.0),
//                                     borderSide: BorderSide(color: Colors.blue),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(25.0),
//                                     borderSide: BorderSide(color: Colors.blue),
//                                   ),
//                                 ),
//                                 textAlign: TextAlign.center,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'Enter your weight';
//                                   } else {
//                                     return null;
//                                   }
//                                 },
//                               ),
//                             ),
//                           ),
//
//                           // ENTER BUTTON
//                           const SizedBox(height: 35),
//                           SizedBox(
//                             width: 230,
//                             height: 70,
//                             child: ElevatedButton(
//                               onPressed: () {},
//                               style: ElevatedButton.styleFrom(
//                                 primary: const Color(0xFFC9F3B5),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(25.0),
//                                 ),
//                               ),
//                               child: const Text(
//                                 'ENTER',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 20,
//                                   letterSpacing: 6,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   // BOTTOM CONTAINER with QUOTE's
//                   const SizedBox(height: 10,),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Container(
//                       width: 400,
//                       height: 100,
//                       decoration: BoxDecoration(
//                           color: secondaryColor,
//                           borderRadius: const BorderRadius.all(Radius.circular(40))),
//                       child: const Center(
//                         child: Padding(
//                           padding: EdgeInsets.all(20.0),
//                           child: Text(
//                             "Stress is like a rocking chair. It gives you something to do but gets you nowhere.",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 15,
//                               fontWeight: FontWeight.w400,
//                               letterSpacing: 4.5,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//
//     if (pickedDate != null) {
//       // Update the TextFormField with the selected date
//       // You can format the date as needed, for example: dd/MM/yyyy
//       String formattedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
//
//       // You can use the formattedDate as needed (e.g., update the TextFormField)
//       print('Selected date: $formattedDate');
//     }
//   }
//
//   void showGenderMenu(BuildContext context) async {
//     String? selectedGender = await showMenu<String>(
//       context: context,
//       position: RelativeRect.fromLTRB(135, 370, 135, 0),
//       items: [
//         PopupMenuItem(
//           child: Text('MALE'),
//           value: 'MALE',
//         ),
//         PopupMenuItem(
//           child: Text('FEMALE'),
//           value: 'FEMALE',
//         ),
//         PopupMenuItem(
//           child: Text('OTHERS'),
//           value: 'OTHERS',
//         ),
//       ],
//     );
//
//     if (selectedGender != null) {
//       setState(() {
//         // Update the gender text field
//         gender.text = selectedGender;
//       });
//     }
//   }
//
//   void showWeightPicker(BuildContext context) async {
//     int? selectedWeight = await showMenu<int>(
//       context: context,
//       position: RelativeRect.fromLTRB(135, 480, 135, 0),
//       items: [
//         PopupMenuItem(
//           child: Text('50 kg'),
//           value: 50,
//         ),
//         PopupMenuItem(
//           child: Text('60 kg'),
//           value: 60,
//         ),
//         PopupMenuItem(
//           child: Text('70 kg'),
//           value: 70,
//         ),
//         // Add more weights as needed
//       ],
//     );
//
//     if (selectedWeight != null) {
//       setState(() {
//         // Update the weight text field
//         weight.text = '$selectedWeight kg';
//       });
//     }
//   }
// }
//
//