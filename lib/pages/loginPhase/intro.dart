import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relaxio/components/button.dart';
import 'package:relaxio/themes/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.84,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(70.0),
                    bottomRight: Radius.circular(70.0),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          "assets/logo.gif",
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.width * 0.4,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.085,
              ),
              MyButton(
                  text: "LOGIN",
                  onTap: () {
                    Get.toNamed('/LogMove');
                    /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()));,*/
                  }),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:relaxioui/components/button.dart';
// import 'package:relaxioui/pages/loginPhase/login.dart';
// import 'package:relaxioui/themes/colors.dart';
//
// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColor,
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//               // crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 400,
//                   height: 665,
//                   decoration: BoxDecoration(
//                     color: secondaryColor,
//                     borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(70.0),
//                       bottomRight: Radius.circular(70.0),
//                     ),
//                   ),
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ClipOval(
//                           child: Image.asset(
//                             "assets/logo.gif",
//                             width: 170,
//                             height: 170,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 40,),
//                 MyButton(text: "LOGIN", onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const Login()),
//                   );
//                 }),
//               ]),
//         ),
//       ),
//     );
//   }
// }