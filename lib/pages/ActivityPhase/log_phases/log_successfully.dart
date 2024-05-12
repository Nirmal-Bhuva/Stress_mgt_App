import 'package:flutter/material.dart';
import 'package:relaxio/themes/colors.dart';

class LogSuccessfully extends StatefulWidget {
  const LogSuccessfully({Key? key}) : super(key: key);

  @override
  _LogSuccessfullyState createState() => _LogSuccessfullyState();
}

class _LogSuccessfullyState extends State<LogSuccessfully>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          Positioned(
            right: -screenWidth * 0.175, // Move 20% outside the left edge
            top: screenHeight * 0.05,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 +
                      (_animation.value *
                          0.5), // Change the factor to adjust the size increase
                  child: Container(
                    height: screenHeight * 0.27, // Adjust size as needed
                    width: screenWidth * 0.58, // Adjust size as needed
                    decoration: BoxDecoration(
                      color: secondaryColor, // Set the color..
                      shape: BoxShape.circle,
                    ),

                    // TOP-MIDDLE CIRCLE - GREEN
                    child: Center(
                      child: Container(
                        height: screenHeight *
                            (0.18 +
                                (_animation.value *
                                    0.09)), // Adjust size as needed
                        width: screenWidth *
                            (0.18 +
                                (_animation.value *
                                    0.09)), // Adjust size as needed
                        decoration: const BoxDecoration(
                          color: Color(0xFFB5E99D), // Set the color to green
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // LOGGED SUCCESSFULLY TEXT
          const Center(
            child: Text(
              '\t\t\t\t\t\tLOGGED\nSUCCESSFULLY',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.5,
              ),
            ),
          ),

          Positioned(
            left: -screenWidth * 0.175, // Move 20% outside the left edge
            bottom: screenHeight * 0.05,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 +
                      (_animation.value *
                          0.5), // Change the factor to adjust the size increase
                  child: Container(
                    height: screenHeight * 0.27, // Adjust size as needed
                    width: screenWidth * 0.58, // Adjust size as needed
                    decoration: BoxDecoration(
                      color: secondaryColor, // Set the color..
                      shape: BoxShape.circle,
                    ),

                    // TOP-MIDDLE CIRCLE - GREEN
                    child: Center(
                      child: Container(
                        height: screenHeight *
                            (0.18 +
                                (_animation.value *
                                    0.09)), // Adjust size as needed
                        width: screenWidth *
                            (0.18 +
                                (_animation.value *
                                    0.09)), // Adjust size as needed
                        decoration: const BoxDecoration(
                          color: Color(0xFFB5E99D), // Set the color to green
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:relaxioui/themes/colors.dart';
//
// class LogSuccessfully extends StatelessWidget {
//   const LogSuccessfully({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: primaryColor,
//
//       // USING STACK TO ALIGN THOSE CIRCLES to be half out of screen
//       body: Stack(
//         children: [
//
//           // TOP CIRCLE - BLUE
//           Positioned(
//             right: -screenWidth * 0.175, // Move 20% outside the left edge
//             top: screenHeight * 0.05,
//             child: Container(
//               height: screenHeight * 0.27, // Adjust size as needed
//               width: screenWidth * 0.58, // Adjust size as needed
//               decoration: BoxDecoration(
//                 color: secondaryColor, // Set the color..
//                 shape: BoxShape.circle,
//               ),
//
//               // TOP-MIDDLE CIRCLE - GREEN
//               child: Center(
//                 child: Container(
//                   height: screenHeight * 0.18, // Adjust size as needed
//                   width: screenWidth * 0.18, // Adjust size as needed
//                   decoration: const BoxDecoration(
//                     color: Color(0xFFB5E99D), // Set the color to green
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           // LOGGED SUCCESSFULLY TEXT
//           const Center(
//             child: Text(
//               '\t\t\t\t\t\tLOGGED\nSUCCESSFULLY',
//               style: TextStyle(
//                 fontSize: 40,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 3.5,
//               ),
//             ),
//           ),
//
//           // BOTTOM CIRCLE - BLUE
//           Positioned(
//             left: -screenWidth * 0.175, // Move 20% outside the left edge
//             bottom: screenHeight * 0.05,
//             child: Container(
//               height: screenHeight * 0.27, // Adjust size as needed
//               width: screenWidth * 0.58, // Adjust size as needed
//               decoration: BoxDecoration(
//                 color: secondaryColor, // Set the color..
//                 shape: BoxShape.circle,
//               ),
//
//               // BOTTOM-MIDDLE CIRCLE - GREEN
//               child: Center(
//                 child: Container(
//                   height: screenHeight * 0.18, // Adjust size as needed
//                   width: screenWidth * 0.18, // Adjust size as needed
//                   decoration: const BoxDecoration(
//                     color: Color(0xFFB5E99D), // Set the color to green
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }