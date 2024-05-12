import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relaxio/themes/colors.dart';

class video extends StatelessWidget {
  video({
    super.key,
    required this.routeName,
  });

  final String routeName;

  @override
  Widget build(BuildContext context) {
    double screenWidth = 0;
    double screenHeight = 0;
    // late String imagename;

    // late List image1 = [];

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: FutureBuilder(
        // Assume you have a Firebase collection called 'carousel_items'
        future: FirebaseFirestore.instance.collection('video').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<DocumentSnapshot> data = snapshot.data!.docs;

            return CarouselSlider.builder(
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: false,
                viewportFraction: 0.5,
                //autoPlay: true, // Enable auto play
                //autoPlayInterval: Duration(seconds: 1),
              ),
              itemCount: data.length.toInt(),
              itemBuilder: (context, index, realIdx) {
                //var musicurl = data[index].get('music_url');
                var videoUrl = data[index].get('filepath');

                //var imageUrl = data[index].get('image_url');
                var videoname = data[index].get('video_name');
                var videocontent = data[index].get('video_content');
                var imageUrl = data[index].get('imageUrls');

                // for (imagename in imageUrl) {
                //   image1.add(imagename);
                // }

                print("hello i am");
                //print(nameUrl);

                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/VideoList', arguments: {
                          "videoUrl": videoUrl,
                          "videoName": videoname,
                          "videoContent": videocontent,
                        });
                        print(videoUrl);
                        print(videoname);
                        print(videocontent);
                      },
                      child: Expanded(
                        child: Container(
                          width: screenWidth * 0.45,
                          height: screenHeight * 0.15,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                30), // Clip the image to rounded corners
                            child: Image.network(
                              //image1[index],
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.04,
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
