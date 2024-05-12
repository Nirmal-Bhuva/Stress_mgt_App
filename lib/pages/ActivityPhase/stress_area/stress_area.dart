import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:relaxio/themes/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Stress_relation_area extends StatefulWidget {
  @override
  final shadowColor = const Color(0xFFCCCCCC);
  final dataList = [
    const _BarData(AppColors.contentColorYellow, 18, 18),
    const _BarData(AppColors.contentColorGreen, 17, 8),
    const _BarData(AppColors.contentColorOrange, 10, 15),
    const _BarData(AppColors.contentColorPink, 2.5, 5),
    const _BarData(AppColors.contentColorBlue, 2, 2.5),
    const _BarData(AppColors.contentColorRed, 2, 2),
  ];
  State<Stress_relation_area> createState() => _Stress_relation_areaState();
}

class _Stress_relation_areaState extends State<Stress_relation_area> {
  BarChartGroupData generateBarGroup(
    int x,
    Color color,
    double value,
    double shadowValue,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 6,
        ),
        BarChartRodData(
          toY: shadowValue,
          color: widget.shadowColor,
          width: 6,
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }

  int touchedGroupIndex = -1;
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  Future<List<Map<String, dynamic>>> fetchData() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('log').get();
    List<Map<String, dynamic>> dataList = [];
    List<Map<String, dynamic>> dataListByMonth = [];
    var requiredMonth = DateTime.now().month.toString().padLeft(2, '0');
    List<String> documentIds = [];

    querySnapshot.docs.forEach((doc) {
      if (doc.exists) {
        print("document id");
        documentIds.add(doc.id);
        print("documentIds" + documentIds.toString());
        print("In query");
        dataList.add(doc.data());
        doc.data().forEach((key, value) {
          var month = key.split("-")[1];
          if (month == requiredMonth) {
            dataListByMonth.add({key: value});
          }
        });
      }
    });
    print(dataListByMonth);
    return dataListByMonth;
    //return dataList;
  }

  @override
  Widget build(BuildContext context) {
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
            feelings.add(data.values.first['impact']);
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

          // Print percentages
          feelingPercentages.forEach((feeling, percentage) {
            print('$feeling: ${percentage.toStringAsFixed(2)}%');
          });
          List<String> feelingPercentageTexts = feelingPercentages.entries
              .map(
                  (entry) => '${entry.key}: ${entry.value.toStringAsFixed(2)}%')
              .toList();

          return Padding(
            padding: const EdgeInsets.all(24),
            child: AspectRatio(
              aspectRatio: 1.4,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceBetween,
                  borderData: FlBorderData(
                    show: true,
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: AppColors.borderColor.withOpacity(0.2),
                      ),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      drawBelowEverything: true,
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            textAlign: TextAlign.left,
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 36,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: _IconWidget(
                              color: widget.dataList[index].color,
                              isSelected: touchedGroupIndex == index,
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: AppColors.borderColor.withOpacity(0.2),
                      strokeWidth: 1,
                    ),
                  ),
                  barGroups: widget.dataList.asMap().entries.map((e) {
                    final index = e.key;
                    final data = e.value;
                    return generateBarGroup(
                      index,
                      data.color,
                      data.value,
                      data.shadowValue,
                    );
                  }).toList(),
                  maxY: 20,
                  barTouchData: BarTouchData(
                    enabled: true,
                    handleBuiltInTouches: false,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.transparent,
                      tooltipMargin: 0,
                      getTooltipItem: (
                        BarChartGroupData group,
                        int groupIndex,
                        BarChartRodData rod,
                        int rodIndex,
                      ) {
                        return BarTooltipItem(
                          rod.toY.toString(),
                          TextStyle(
                            fontWeight: FontWeight.bold,
                            color: rod.color,
                            fontSize: 18,
                            shadows: const [
                              Shadow(
                                color: Colors.black26,
                                blurRadius: 12,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    touchCallback: (event, response) {
                      if (event.isInterestedForInteractions &&
                          response != null &&
                          response.spot != null) {
                        setState(() {
                          touchedGroupIndex =
                              response.spot!.touchedBarGroupIndex;
                        });
                      } else {
                        setState(() {
                          touchedGroupIndex = -1;
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BarData {
  const _BarData(this.color, this.value, this.shadowValue);
  final Color color;
  final double value;
  final double shadowValue;
}

class _IconWidget extends ImplicitlyAnimatedWidget {
  const _IconWidget({
    required this.color,
    required this.isSelected,
  }) : super(duration: const Duration(milliseconds: 300));
  final Color color;
  final bool isSelected;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _IconWidgetState();
}

class _IconWidgetState extends AnimatedWidgetBaseState<_IconWidget> {
  Tween<double>? _rotationTween;

  @override
  Widget build(BuildContext context) {
    final rotation = math.pi * 4 * _rotationTween!.evaluate(animation);
    final scale = 1 + _rotationTween!.evaluate(animation) * 0.5;
    return Transform(
      transform: Matrix4.rotationZ(rotation).scaled(scale, scale),
      origin: const Offset(14, 14),
      child: Icon(
        widget.isSelected ? Icons.face_retouching_natural : Icons.face,
        color: widget.color,
        size: 28,
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _rotationTween = visitor(
      _rotationTween,
      widget.isSelected ? 1.0 : 0.0,
      (dynamic value) => Tween<double>(
        begin: value as double,
        end: widget.isSelected ? 1.0 : 0.0,
      ),
    ) as Tween<double>?;
  }
}



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class Stress_Area extends StatefulWidget {
//   @override
//   State<Stress_Area> createState() => _Stress_AreaState();
// }

// class _Stress_AreaState extends State<Stress_Area> {
//   String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

//   Future<List<Map<String, dynamic>>> fetchData() async {
//     QuerySnapshot<Map<String, dynamic>> querySnapshot =
//         await FirebaseFirestore.instance.collection('log').get();
//     List<Map<String, dynamic>> dataList = [];
//     List<Map<String, dynamic>> dataListByMonth = [];
//     var requiredMonth = DateTime.now().month.toString().padLeft(2, '0');

//     querySnapshot.docs.forEach((doc) {
//       if (doc.exists) {
//         print("In query");
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
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
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

//           var nk = Text(feelings.toString());
//           print(nk);

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

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: PieChart(
//               swapAnimationDuration: Duration(milliseconds: 150), // Optional
//               swapAnimationCurve: Curves.linear,
//               PieChartData(
//                 pieTouchData: PieTouchData(
//                   touchCallback: (FlTouchEvent event, pieTouchResponse) {
//                     setState(() {
//                       if (!event.isInterestedForInteractions ||
//                           pieTouchResponse == null ||
//                           pieTouchResponse.touchedSection == null) {
//                         touchedIndex = -1;
//                         return;
//                       }
//                       touchedIndex =
//                           pieTouchResponse.touchedSection!.touchedSectionIndex;
//                     });
//                   },
//                 ),
//                 borderData: FlBorderData(
//                   show: false,
//                 ),
//                 sectionsSpace: 0,
//                 centerSpaceRadius: 50,
//                 sections: List.generate(
//                   feelingPercentageTexts.length,
//                   (index) {
//                     final isTouched =
//                         index == 0; // Example: Highlight the first section
//                     final double fontSize = isTouched ? 16 : 12;
//                     final double radius = isTouched ? 120 : 120;

//                     return PieChartSectionData(
//                       // color:
//                       //     getRandomColor(), // You can define your own color function
//                       // value: dataList[index].count.toDouble(),
//                       // title:
//                       //     '${dataList[index].feeling} (${dataList[index].count})',
//                       // radius: radius,
//                       // titleStyle: TextStyle(
//                       //   fontSize: fontSize,
//                       //   fontWeight: FontWeight.bold,
//                       //   color: const Color(0xffffffff),
//                       color: getRandomColor(),
//                       value: 40,
//                       title:
//                           '${feelings[index]} (${feelingPercentageTexts[index]})',
//                       radius: radius,
//                       titleStyle: TextStyle(
//                         fontSize: fontSize,
//                         fontWeight: FontWeight.bold,
//                         color: const Color(0xffffffff),
//                         shadows: [Shadow(color: Colors.black, blurRadius: 2)],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//       // SizedBox(
//       //   width: screenWidth * 0.35,
//       //   height: screenHeight * 0.06,
//       //   child: ElevatedButton(
//       //     onPressed: () {
//       //       Get.toNamed('/logSuccessfully');
//       //     },
//       //     style: ElevatedButton.styleFrom(
//       //       backgroundColor: const Color(0xFFC9F3B5),
//       //       shape: RoundedRectangleBorder(
//       //         borderRadius: BorderRadius.circular(25.0),
//       //       ),
//       //     ),
//       //     child: const Text(
//       //       'Stress relation',
//       //       style: TextStyle(
//       //         color: Colors.black,
//       //         fontSize: 15,
//       //         letterSpacing: 6,
//       //         fontWeight: FontWeight.bold,
//       //       ),
//       //     ),
//       //   ),
//       // ),
//     );
//   }

//   // Example function to generate random colors
//   Color getRandomColor() {
//     return Color.fromRGBO(
//       50 + (DateTime.now().microsecondsSinceEpoch % 200),
//       50 + (DateTime.now().microsecondsSinceEpoch % 200),
//       50 + (DateTime.now().microsecondsSinceEpoch % 200),
//       1,
//     );
//   }
// }
       
//////////////////////////////////////////////////////////////////////

       
  // Future<List<FeelingData>> fetchData() async {
  //   final now = DateTime.now();

  //   // Create timestamps for the first and last day of the month
  //   final firstDay = DateTime(now.year, now.month, 1);
  //   final lastDay = DateTime(now.year, now.month + 1, 1)
  //       .subtract(Duration(microseconds: 1));
  //   String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  //   // Create the Firestore query with a range based on 'currentDate' field

  //   print(firstDay);
  //   print(lastDay);
  //   print("now" + now.toString());

  //   QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
  //       .instance
  //       .collection('log')
  //       .where('currentDate', isGreaterThanOrEqualTo: firstDay)
  //       .where('currentDate', isLessThanOrEqualTo: lastDay)
  //       .get();
  //   List<FeelingData> feelingDataList = [];
  //   Map<String, int> countMap = {};

  //   querySnapshot.docs.forEach((doc) {
  //     if (doc.exists) {
  //       String feeling = doc[currentDate]['feeling'];
  //       countMap[feeling] = (countMap[feeling] ?? 0) + 1;
  //       print(countMap[feeling]);
  //     }
  //   });

  //   countMap.forEach((feeling, count) {
  //     feelingDataList.add(FeelingData(feeling, count));
  //   });

  //   return feelingDataList;
  // }

  // Future<List<FeelingData>> fetchData() async {
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //       await FirebaseFirestore.instance.collection('log').get();
  //   List<FeelingData> feelingDataList = [];
  //   Map<String, int> countMap = {};

  //   querySnapshot.docs.forEach((doc) {
  //     if (doc.exists) {
  //       String feeling = doc[currentDate]['feeling'];
  //       countMap[feeling] = (countMap[feeling] ?? 0) + 1;
  //       print("hello" + feeling);
  //     }
  //   });

  //   countMap.forEach((feeling, count) {
  //     feelingDataList.add(FeelingData(feeling, count));
  //   });
  //   print(feelingDataList);

  //   return feelingDataList;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     int touchedIndex = -1;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Feeling Pie Chart'),
//       ),
//       body: FutureBuilder<List<FeelingData>>(
//         future: futureFeelingData,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           List<FeelingData> feelingDataList = snapshot.data!;
//           if (feelingDataList.isEmpty) {
//             return Center(child: Text('No data found'));
//           }

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: PieChart(
//               swapAnimationDuration: Duration(milliseconds: 150), // Optional
//               swapAnimationCurve: Curves.linear,
//               PieChartData(
//                 pieTouchData: PieTouchData(
//                   touchCallback: (FlTouchEvent event, pieTouchResponse) {
//                     setState(() {
//                       if (!event.isInterestedForInteractions ||
//                           pieTouchResponse == null ||
//                           pieTouchResponse.touchedSection == null) {
//                         touchedIndex = -1;
//                         return;
//                       }
//                       touchedIndex =
//                           pieTouchResponse.touchedSection!.touchedSectionIndex;
//                     });
//                   },
//                 ),
//                 borderData: FlBorderData(
//                   show: false,
//                 ),
//                 sectionsSpace: 0,
//                 centerSpaceRadius: 50,
//                 sections: List.generate(
//                   feelingDataList.length,
//                   (index) {
//                     final isTouched =
//                         index == 0; // Example: Highlight the first section
//                     final double fontSize = isTouched ? 16 : 12;
//                     final double radius = isTouched ? 90 : 50;

//                     return PieChartSectionData(
//                       // color:
//                       //     getRandomColor(), // You can define your own color function
//                       // value: feelingDataList[index].count.toDouble(),
//                       // title:
//                       //     '${feelingDataList[index].feeling} (${feelingDataList[index].count})',
//                       // radius: radius,
//                       // titleStyle: TextStyle(
//                       //   fontSize: fontSize,
//                       //   fontWeight: FontWeight.bold,
//                       //   color: const Color(0xffffffff),
//                       color: getRandomColor(),
//                       value: 40,
//                       title:
//                           '${feelingDataList[index].feeling} (${feelingDataList[index].count})',
//                       radius: radius,
//                       titleStyle: TextStyle(
//                         fontSize: fontSize,
//                         fontWeight: FontWeight.bold,
//                         color: const Color(0xffffffff),
//                         shadows: [Shadow(color: Colors.black, blurRadius: 2)],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // Example function to generate random colors
//   Color getRandomColor() {
//     return Color.fromRGBO(
//       50 + (DateTime.now().microsecondsSinceEpoch % 200),
//       50 + (DateTime.now().microsecondsSinceEpoch % 200),
//       50 + (DateTime.now().microsecondsSinceEpoch % 200),
//       1,
//     );
//   }
// }



/*

//           // Build the text representation of the fetched data
//           String textData = '';
//           for (int i = 0; i < dataList.length; i++) {
//             textData += '''
// Document $i:
// currentDate: ${dataList[i]['17-03-2024']['currentDate']}
// feeling: ${dataList[i]['17-03-2024']['feeling']}
// timestamp: ${dataList[i]['17-03-2024']['timestamp']}

// ''';
//           }

*/