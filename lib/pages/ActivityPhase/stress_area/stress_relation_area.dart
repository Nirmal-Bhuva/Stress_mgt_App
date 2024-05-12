import 'dart:math' as math;
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:relaxio/themes/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Stress_Area extends StatefulWidget {
  @override
  State<Stress_Area> createState() => _Stress_AreaState();
}

class _Stress_AreaState extends State<Stress_Area> {
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  Future<List<Map<String, dynamic>>> fetchData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    String emailId = currentUser?.email ?? "";
    List<Map<String, dynamic>> dataListByMonth = [];
    var requiredMonth = DateTime.now().month.toString().padLeft(2, '0');

    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('log').doc(emailId).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        // Iterate over the fields in the data map
        data.forEach((key, value) {
          var month = key.split("-")[1];
          if (month == requiredMonth) {
            dataListByMonth.add({key: value});
          }
          // You can perform operations with each field here
        });
      } else {
        print('Data is null');
      }
    } else {
      print('Document does not exist');
    }

    // QuerySnapshot<Map<String, dynamic>> querySnapshot =
    //     await FirebaseFirestore.instance.collection('log').get();
    List<Map<String, dynamic>> dataList = [];

    List<String> documentIds = [];

    // querySnapshot.docs.forEach((doc) {
    //   if (doc.exists) {
    //     print("document id");
    //     documentIds.add(doc.id);
    //     print(documentIds);
    //     print("In query");

    //     dataList.add(doc.data());
    //     doc.data().forEach((key, value) {
    //       var month = key.split("-")[1];
    //       if (month == requiredMonth) {
    //         dataListByMonth.add({key: value});
    //       }
    //     });
    //   }
    // });
    print(dataListByMonth);
    return dataListByMonth;
    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    int touchedIndex = -1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Text Example'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          List<Map<String, dynamic>> dataList = snapshot.data!;
          if (dataList.isEmpty) {
            return Center(child: Text('No data found'));
          }

          List<String> feelings = []; // Create an empty list to store feelings

          for (var data in dataList) {
            feelings.add(data.values.first['feeling']);
            print(feelings);
          }

          var nk = Text(feelings.toString());
          print(nk);

          Map<String, double> feelingPercentages = {};
          int totalEntries = feelings.length;

          feelings.forEach((feeling) {
            feelingPercentages[feeling] =
                (feelings.where((item) => item == feeling).length /
                        totalEntries) *
                    100;
          });

          // Print percentageschr
          feelingPercentages.forEach((feeling, percentage) {
            print('$feeling: ${percentage.toStringAsFixed(2)}%');
          });
          List<String> feelingPercentageTexts = feelingPercentages.entries
              .map(
                  (entry) => '${entry.key}: ${entry.value.toStringAsFixed(2)}%')
              .toList();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: PieChart(
              swapAnimationDuration: Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.linear,
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 50,
                sections: List.generate(
                  feelingPercentageTexts.length,
                  (index) {
                    final isTouched =
                        index == 0; // Example: Highlight the first section
                    final double fontSize = isTouched ? 16 : 12;
                    final double radius = isTouched ? 120 : 120;

                    return PieChartSectionData(
                      // color:
                      //     getRandomColor(), // You can define your own color function
                      // value: dataList[index].count.toDouble(),
                      // title:
                      //     '${dataList[index].feeling} (${dataList[index].count})',
                      // radius: radius,
                      // titleStyle: TextStyle(
                      //   fontSize: fontSize,
                      //   fontWeight: FontWeight.bold,
                      //   color: const Color(0xffffffff),
                      color: getRandomColor(),
                      value: 40,
                      title:
                          '${feelings[index]} (${feelingPercentageTexts[index]})',
                      radius: radius,
                      titleStyle: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffffffff),
                        shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
      // SizedBox(
      //   width: screenWidth * 0.35,
      //   height: screenHeight * 0.06,
      //   child: ElevatedButton(
      //     onPressed: () {
      //       Get.toNamed('/logSuccessfully');
      //     },
      //     style: ElevatedButton.styleFrom(
      //       backgroundColor: const Color(0xFFC9F3B5),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(25.0),
      //       ),
      //     ),
      //     child: const Text(
      //       'Stress relation',
      //       style: TextStyle(
      //         color: Colors.black,
      //         fontSize: 15,
      //         letterSpacing: 6,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  // Example function to generate random colors
  Color getRandomColor() {
    List<Color> darkColors = [
      Colors.black,
      Colors.blueGrey,
      Colors.brown,
      Colors.deepPurple,
      Colors.green,
      Colors.indigo,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.yellow,
    ];

    // int randomIndex = DateTime.now().microsecondsSinceEpoch % darkColors.length;

    // return darkColors[randomIndex];

    Random random = Random();
    int randomIndex = random.nextInt(darkColors.length);
    return darkColors[randomIndex];

    // return Color.fromRGBO(
    //   50 + (DateTime.now().microsecondsSinceEpoch % 200),
    //   50 + (DateTime.now().microsecondsSinceEpoch % 200),
    //   50 + (DateTime.now().microsecondsSinceEpoch % 200),
    //   1,
    // );
  }
}

// class Stress_Area extends StatefulWidget {
//   @override
//   // final shadowColor = const Color(0xFFCCCCCC);
//   // final dataList = [
//   //   const _BarData(AppColors.contentColorYellow, 18, 18),
//   //   const _BarData(AppColors.contentColorGreen, 17, 8),
//   //   const _BarData(AppColors.contentColorOrange, 10, 15),
//   //   const _BarData(AppColors.contentColorPink, 2.5, 5),
//   //   const _BarData(AppColors.contentColorBlue, 2, 2.5),
//   //   const _BarData(AppColors.contentColorRed, 2, 2),
//   // ];
//   State<Stress_Area> createState() => _Stress_AreaState();
// }

// class _Stress_AreaState extends State<Stress_Area> {
//   int touchedGroupIndex = -1;
//   String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

//   Future<List<Map<String, dynamic>>> fetchData() async {
//     QuerySnapshot<Map<String, dynamic>> querySnapshot =
//         await FirebaseFirestore.instance.collection('log').get();
//     List<Map<String, dynamic>> dataList = [];
//     List<Map<String, dynamic>> dataListByMonth = [];
//     var requiredMonth = DateTime.now().month.toString().padLeft(2, '0');

//     querySnapshot.docs.forEach((doc) {
//       if (doc.exists) {
//         print("In my query");
//         dataList.add(doc.data());
//         doc.data().forEach((key, value) {
//           var month = key.split("-")[1];
//           if (month == requiredMonth) {
//             dataListByMonth.add({key: value});
//           }
//         });
//       }
//     });
//     print(dataListByMonth);
//     return dataListByMonth;
//     //return dataList;
//   }

//   @override
//   Widget build(BuildContext context) {
//     int touchedIndex = -1;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firestore Text Example'),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: fetchData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           List<Map<String, dynamic>> dataList = snapshot.data!;
//           if (dataList.isEmpty) {
//             return Center(child: Text('No data found'));
//           }

//           List<String> feelings = []; // Create an empty list to store feelings

//           for (var data in dataList) {
//             feelings.add(data.values.first['feeling']);
//             print(feelings);
//           }
//           List<String> impact = []; // Create an empty list to store feelings

//           for (var data in dataList) {
//             impact.add(data.values.first['impact']);
//             print(impact);
//           }
//           // var nk = Text(feelings.toString());
//           // print(nk);

//           Map<String, double> feelingPercentages = {};
//           int totalEntries = feelings.length;

//           feelings.forEach((feeling) {
//             feelingPercentages[feeling] =
//                 (feelings.where((item) => item == feeling).length /
//                         totalEntries) *
//                     100;
//           });

//           // Print percentages
//           feelingPercentages.forEach((feeling, percentage) {
//             print('$feeling: ${percentage.toStringAsFixed(2)}%');
//           });
//           List<String> feelingPercentageTexts = feelingPercentages.entries
//               .map(
//                   (entry) => '${entry.key}: ${entry.value.toStringAsFixed(2)}%')
//               .toList();

//           return SfCartesianChart(
//             primaryXAxis: CategoryAxis(),
//             series: <CartesianSeries>[
//               ColumnSeries<Map<String, dynamic>, String>(
//                 dataSource: feelingPercentageTexts
//                     .map((text) => {'text': text})
//                     .toList(),
//                 xValueMapper: (datum, _) => datum['text'].toString(),
//                 yValueMapper: (datum, _) => double.parse(datum['text']
//                     .toString()
//                     .split(': ')[1]
//                     .replaceAll('%', '')),
//                 dataLabelSettings: DataLabelSettings(isVisible: true),
//               ),
//             ],
//           );

//           // return Padding(
//           //   padding: const EdgeInsets.all(16.0),
//           //   child: Center(
//           //     child: Container(
//           //       height: 300,
//           //       child: BarChart(
//           //         BarChartData(
//           //           barTouchData: BarTouchData(
//           //             enabled: false,
//           //           ),
//           //       titlesData:  FlTitlesData(
//           //         show: true,
//           //         bottomTitles: SideTitles(
//           //           showTitles: true,
//           //           getTextStyles: (context, value) => const TextStyle(
//           //             color: Colors.black,
//           //             fontWeight: FontWeight.bold,
//           //             fontSize: 14,
//           //           ),
//           //           margin: 20,
//           //           getTitles: (double value) {
//           //             return 'Label ${value.toInt() + 1}';
//           //           },
//           //         ),

//           //             leftTitles: SideTitles(
//           //               showTitles: true,
//           //               getTextStyles: (context, value) => const TextStyle(
//           //                 color: Colors.black,
//           //                 fontWeight: FontWeight.bold,
//           //                 fontSize: 14,
//           //               ),
//           //               margin: 20,
//           //               getTitles: (double value) {
//           //                 return '${value.toInt()}';
//           //               },
//           //             ),
//           //           ),
//           //           gridData: FlGridData(
//           //             show: true,
//           //             checkToShowHorizontalLine: (value) => value % 5 == 0,
//           //             getDrawingHorizontalLine: (value) => FlLine(
//           //               color: Colors.grey,
//           //               strokeWidth: 1,
//           //             ),
//           //           ),
//           //           borderData: FlBorderData(
//           //             show: true,
//           //             border: Border.all(
//           //               color: Colors.black,
//           //               width: 1,
//           //             ),
//           //           ),
//           //           barGroups: List.generate(widget.values1.length, (index) {
//           //             return BarChartGroupData(
//           //               x: index,
//           //               barsSpace: 8,
//           //               barRods: [
//           //                 BarChartRodData(
//           //                   y: widget.values1[index],
//           //                   colors: [Colors.blue],
//           //                 ),
//           //                 BarChartRodData(
//           //                   y: widget.values2[index],
//           //                   colors: [Colors.red],
//           //                 ),
//           //               ],
//           //             );
//           //           }),
//           //         ),
//           //       ),
//           //     ),
//           //   ),
//           // );
//         },
//       ),
//     );
//   }
// }
