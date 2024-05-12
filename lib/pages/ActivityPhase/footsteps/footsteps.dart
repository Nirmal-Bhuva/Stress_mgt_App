import 'package:flutter/material.dart';
import 'dart:async';
import 'package:health_kit/health_kit.dart';
import 'package:relaxio/themes/colors.dart';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// Basic skinning example. The skinning states is set in the Rive editor and
/// triggers are used to change the value.
class footsteps extends StatefulWidget {
  const footsteps({Key? key}) : super(key: key);

  @override
  State<footsteps> createState() => _footstepsState();
}

class _footstepsState extends State<footsteps> {
  num total = 0.0;
  String message = '';
  int betterhealth_steps = 10000;

  static const _skinMapping = {
    "Skin_0": "Plain",
    "Skin_1": "Summer",
    "Skin_2": "Elvis",
    "Skin_3": "Superhero",
    "Skin_4": "Astronaut"
  };

  String _currentState = 'Plain';

  SMITrigger? _skin;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'Motion',
      onStateChange: _onStateChange,
    );

    artboard.addController(controller!);
    _skin = controller.findInput<bool>('Skin') as SMITrigger;
  }

  void _onStateChange(String stateMachineName, String stateName) {
    if (stateName.contains("Skin_")) {
      setState(() {
        _currentState = _skinMapping[stateName] ?? 'Plain';
      });
    }
  }

  void _swapSkin() {
    _skin?.fire();
  }

  @override
  Widget build(BuildContext context) {
    const textColor = Color(0xFFefcb7d);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Skinning Demo'),
      ),
      body: Stack(
        children: [
          Center(
            child: RiveAnimation.asset(
              'assets/skins_demo.riv',
              fit: BoxFit.cover,
              onInit: _onRiveInit,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
                    '10000 steps per day',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
                FilledButton(
                  onPressed: _swapSkin,
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xFF7d99ef)),
                  ),
                  child: const Text('Swap Skin'),
                ),
                //const Spacer(),
                const SizedBox(height: 300),

                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(
                              0xFF7d99ef), // Convert hexadecimal to Color object
                        ),
                        onPressed: () async {
                          getYesterdayStep();
                        },
                        child: Text(
                          "Get Today's Step count",
                          style: TextStyle(
                            color: Colors.white, // Text color of the TextButton
                          ),
                        ),
                      ),
                      Text(
                        total.toString(),
                        style: TextStyle(
                          color: Colors.black, // Text color of the Text widget
                          fontSize: 18, // Example: Set font size to 18
                          fontWeight: FontWeight
                              .bold, // Example: Set font weight to bold
                        ),
                      ),
                      Text(
                        message,
                        style: TextStyle(
                          color: Colors.black, // Text color of the Text widget
                          fontSize: 15, // Example: Set font size to 18
                          fontWeight: FontWeight
                              .bold, // Example: Set font weight to bold
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),

                Text(
                  'Skin: $_currentState',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<bool> readPermissionsForHealthKit() async {
    try {
      final responses = await HealthKit.hasPermissions([DataType.STEP_COUNT]);

      if (!responses) {
        final value = await HealthKit.requestPermissions([DataType.STEP_COUNT]);

        return value;
      } else {
        return true;
      }
    } on UnsupportedException catch (e) {
      // thrown in case e.dataType is unsupported
      print(e);
      return false;
    }
  }

  void checkGoalReached() {
    if (total < betterhealth_steps) {
      setState(() {
        message =
            'You cannot fulfill your goal. Remaining steps: ${betterhealth_steps - total}';
      });
    } else if (total == betterhealth_steps) {
      setState(() {
        message = 'Congratulations! You have achieved your goal.';
      });
    }
  }

  void getYesterdayStep() async {
    var permissionsGiven = await readPermissionsForHealthKit();

    // if (permissionsGiven) {
    //   var current = DateTime.now();

    //   var dateFrom = DateTime.now().subtract(Duration(
    //     hours: current.hour + 24,
    //     minutes: current.minute,
    //     seconds: current.second,
    //   ));
    //   var dateTo = dateFrom.add(Duration(
    //     hours: 23,
    //     minutes: 59,
    //     seconds: 59,
    //   ));

    //   print('dateFrom: $dateFrom');
    //   print('dateTo: $dateTo');

    //   try {
    //     var results = await HealthKit.read(
    //       DataType.STEP_COUNT,
    //       dateFrom: dateFrom,
    //       dateTo: dateTo,
    //     );
    //     if (results != null) {
    //       for (var result in results) {
    //         total = result.value;
    //       }
    //     }
    //     setState(() {
    //       checkGoalReached();
    //     });
    //     print('value: $total');
    //   } on Exception catch (ex) {
    //     print('Exception in getYesterdayStep: $ex');
    //   }
    // }
    if (permissionsGiven) {
      var current = DateTime.now();

      var dateFrom = DateTime(
        current.year,
        current.month,
        current.day,
        0,
        0,
        0,
      );
      var dateTo = DateTime(
        current.year,
        current.month,
        current.day,
        current.hour,
        current.minute,
        current.second,
      );

      print('dateFrom: $dateFrom');
      print('dateTo: $dateTo');

      try {
        var results = await HealthKit.read(
          DataType.STEP_COUNT,
          dateFrom: dateFrom,
          dateTo: dateTo,
        );
        if (results != null) {
          for (var result in results) {
            total = result.value;
          }
        }
        setState(() {
          checkGoalReached();
        });
        print('value: $total');
      } on Exception catch (ex) {
        print('Exception in getTodayStep: $ex');
      }
    }
  }
}




// class footsteps extends StatefulWidget {
//   @override
//   _footstepsState createState() => _footstepsState();
// }

// class _footstepsState extends State<footsteps> {
//   num total = 0.0;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = 0;
//     double screenHeight = 0;
//     TextEditingController txtName = new TextEditingController();

//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Health Kit'),
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               // Navigate back when the button is pressed
//               Navigator.pop(context);
//             },
//           ),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: Container(
//                 width: screenWidth * 0.45,
//                 height: screenHeight * 0.20,
//                 decoration: BoxDecoration(
//                   color: secondaryColor,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(
//                       30), // Clip the image to rounded corners
//                   child: Image.asset(
//                     //image1[index],
//                     'assets/running.png',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             TextField(
//               controller: txtName,
//               obscureText: true,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Enter your goal of steps',
//               ),
//             ),
//             Container(
//               width: double.infinity,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   TextButton(
//                     child: Text("Get Yesterday's Step count"),
//                     onPressed: () async {
//                       getYesterdayStep();
//                     },
//                   ),
//                   Text(total.toString()),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<bool> readPermissionsForHealthKit() async {
//     try {
//       final responses = await HealthKit.hasPermissions([DataType.STEP_COUNT]);

//       if (!responses) {
//         final value = await HealthKit.requestPermissions([DataType.STEP_COUNT]);

//         return value;
//       } else {
//         return true;
//       }
//     } on UnsupportedException catch (e) {
//       // thrown in case e.dataType is unsupported
//       print(e);
//       return false;
//     }
//   }

//   void getYesterdayStep() async {
//     var permissionsGiven = await readPermissionsForHealthKit();

//     if (permissionsGiven) {
//       var current = DateTime.now();

//       var dateFrom = DateTime.now().subtract(Duration(
//         hours: current.hour + 24,
//         minutes: current.minute,
//         seconds: current.second,
//       ));
//       var dateTo = dateFrom.add(Duration(
//         hours: 23,
//         minutes: 59,
//         seconds: 59,
//       ));

//       print('dateFrom: $dateFrom');
//       print('dateTo: $dateTo');

//       try {
//         var results = await HealthKit.read(
//           DataType.STEP_COUNT,
//           dateFrom: dateFrom,
//           dateTo: dateTo,
//         );
//         if (results != null) {
//           for (var result in results) {
//             total = result.value;
//           }
//         }
//         setState(() {});
//         print('value: $total');
//       } on Exception catch (ex) {
//         print('Exception in getYesterdayStep: $ex');
//       }
//     }
//   }
// }
