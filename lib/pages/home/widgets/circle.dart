import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCircle extends StatelessWidget {
  const MyCircle({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            // Assume you have a Firebase collection called 'carousel_items'
            future: FirebaseFirestore.instance
                .collection('stress_reduction_techniques')
                .get(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<DocumentSnapshot> data = snapshot.data!.docs;
                //List<DocumentSnapshot> data2 = snapshot.data![1].docs;
                //List<DocumentSnapshot> data3 = snapshot.data![2].docs;
                // Add more names if needed
                print("data2");
                //print(data3);
                //print(data2);
                //print(data2.length);
                //print(data3.length);
                //print(data1.length);

                return CarouselSlider.builder(
                    options: CarouselOptions(
                      aspectRatio: 3.0,
                      enlargeCenterPage: true,
                      viewportFraction: 0.4,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 5),
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index, realIdx) {
                      var name1 = data[index].get('technique_name');
                      //print("name1" + name1);

                      //if (name1 != "MusicList" && name1 != "ArticleList") {
                      // Use data from the first collection
                      //var musicUrl = data2[index].get('filepath');
                      //var nameUrl = data2[index].get('audio_name');
                      // Rest of your itemBuilder logic for the first collection
                      // ...

                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('/$name1' //, arguments: {
                              //"musicUrl": musicUrl,
                              //"nameUrl": nameUrl
                              //});
                              );
                          //print('/$name1');
                          //print('Button pressed for image at index $index');
                        },
                        child: Container(
                          height: screenHeight * 0.1,
                          width: screenWidth * 0.21,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: Text(name1),
                        ),
                      );
                      //   } else if (name1 == "MusicList") {
                      //     // Use data from the second collection
                      //     //var name = data1[index - data1.length].get('technique_name');
                      //     var musicUrl = data2[index].get('filepath');
                      //     var nameUrl = data2[index].get('audio_name');
                      //     // Rest of your itemBuilder logic for the second collection
                      //     // ...

                      //     return Expanded(
                      //       child: GestureDetector(
                      //         onTap: () {
                      //           Get.toNamed('/$name1', arguments: {
                      //             "musicUrl": musicUrl,
                      //             "nameUrl": nameUrl
                      //           });
                      //           //print('/$name1');
                      //           //print('Button pressed for image at index $index');
                      //         },
                      //         child: Container(
                      //           height: screenHeight * 0.1,
                      //           width: screenWidth * 0.21,
                      //           decoration: BoxDecoration(
                      //             shape: BoxShape.circle,
                      //             color: Colors.grey,
                      //           ),
                      //           child: Text(name1),
                      //         ),
                      //       ),
                      //     );
                      //   } else /*(name1 == "ArticleList")*/ {
                      //     // Use data from the second collection
                      //     //var name = data1[index - data1.length].get('technique_name');
                      //     var article_name = data2[index].get('article_name');
                      //     var article_content = data2[index].get('article_content');

                      //     // Rest of your itemBuilder logic for the second collection
                      //     // ...

                      //     return Expanded(
                      //       child: GestureDetector(
                      //         onTap: () {
                      //           Get.toNamed('/$name1', arguments: {
                      //             "article_name": article_name,
                      //             "article_content": article_content
                      //           });
                      //           //print('/$name1');
                      //           //print('Button pressed for image at index $index');
                      //         },
                      //         child: Container(
                      //           height: screenHeight * 0.1,
                      //           width: screenWidth * 0.21,
                      //           decoration: BoxDecoration(
                      //             shape: BoxShape.circle,
                      //             color: Colors.grey,
                      //           ),
                      //           child: Text(
                      //             "hello",
                      //             // style: TextStyle(
                      //             //   color: Color.fromARGB(
                      //             //       255, 55, 224, 222), // Set the text color
                      //             //   fontWeight: FontWeight
                      //             //       .bold, // Set the text fontWeight if needed
                      //             // ),
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   }
                      //   // else {
                      //   //   return Text("nothing");
                      //   // }
                      // });
                    });
              }
            }));
  }
}
  
                /*} else {
                  // Use data from the second collection
                  var name = data1[index - data1.length].get('technique_name');
                  var musicUrl = data2[index - data1.length].get('filepath');
                  var nameUrl = data2[index - data1.length].get('audio_name');
                  // Rest of your itemBuilder logic for the second collection
                  // ...

                  return Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed('/$name', arguments: {
                              "musicUrl": musicUrl,
                              "nameUrl": nameUrl
                            });
                            print('/$name');
                            print('Button pressed for image at index $index');
                          },
                          child: Container(
                            height: screenHeight * 0.1,
                            width: screenWidth * 0.21,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                            child: Text(name),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            );
          }
        },
      ),*/

      /*FutureBuilder(
        // Assume you have a Firebase collection called 'carousel_items'
        future: FirebaseFirestore.instance
            .collection('stress_reduction_techniques')
            .get(),

        /*future: Future.wait([
          FirebaseFirestore.instance
              .collection('stress_reduction_techniques')
              .get(),
          FirebaseFirestore.instance.collection('audio').get(),
          // Add more collections as needed
        ]),*/

        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Access each QuerySnapshot from the List
            List<DocumentSnapshot> data = snapshot.data!.docs;

            //DocumentSnapshot data =
            //snapshot.data![0].docs; // Data from first collection
            //List<DocumentSnapshot> data2 =
            // snapshot.data![1].docs; // Data from second collection
            //List<DocumentSnapshot> combinedData = [...data1, ...data2];

            print("combined");
            // print(combinedData);
            // print(data1.length);
            // print(data2.length);
            print("com2");

            // Access more collections if needed
            return CarouselSlider.builder(
                options: CarouselOptions(
                  aspectRatio: 3.0,
                  enlargeCenterPage: true,
                  viewportFraction: 0.4,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlay: true, // Enable auto play
                  autoPlayInterval: Duration(seconds: 1),
                ),
                itemCount: data.length,
                itemBuilder: (context, index, realIdx) {
                  var name = data[index].get('technique_name');
                  //var musicUrl = data[index].get('filepath');
                  //var imageUrl = data[index].get('image_url');
                  //var nameUrl = data[index].get('audio_name');
                  print("t name");
                  //print(nameUrl);

                  //print(index);
                  print("realid");
                  //print(realIdx);
                  print("realll");

                  print("hello i am");
                  //print(videoUrl);
                  return Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed("/");
                          },
                          child: Container(
                              height: screenHeight * 0.1,
                              width: screenWidth * 0.21,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                                //borderRadius: BorderRadius.circular(50),
                              ),
                              //child: Image.network(
                              //imageUrl,
                              //fit: BoxFit.cover,
                              //),

                              child: Text(data[index].get(
                                  'technique_name')) //child: Image.network(imageUrl, fit: BoxFit.cover),
                              ),
                        ),
                      ),
                    ],
                  );
                });
          }
        },
      ),*/
  //  );
 // }
//}
