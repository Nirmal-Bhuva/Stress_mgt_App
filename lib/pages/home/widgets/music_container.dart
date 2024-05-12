import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relaxio/themes/colors.dart';

class audio extends StatelessWidget {
  audio({
    super.key,
    required this.routeName,
  });

  final String routeName;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> fetchData() async {
    try {
      // Fetch the document from collectionA
      DocumentSnapshot collectionADoc =
          await firestore.collection('article_category').doc().get();

      // Get the reference field
      DocumentReference referenceToCollectionB =
          collectionADoc['category_name'];

      // Fetch the document from collectionB using the reference
      DocumentSnapshot collectionBDoc = await referenceToCollectionB.get();

      // Access the data in the referenced document
      print('Data from collectionB: ${collectionBDoc.data()}');
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = 0;
    double screenHeight = 0;
    late String imagename;

    late List image1 = [];

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: FutureBuilder(
        // Assume you have a Firebase collection called 'carousel_items'
        future: FirebaseFirestore.instance.collection('audio').get(),
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
                var musicUrl = data[index].get('audioUrls');
                //var imageUrl = data[index].get('image_url');
                var nameUrl = data[index].get('audioNames');
                var imageUrl = data[index].get('imageUrl');

                //var category = data[index].get('category_name');

                print("gls unim");

                print(imageUrl);
                print("gls i m ");

                // for (imagename in imageUrl) {
                //   image1.add(imagename);
                // }
                //print(image1);
                //print("gls hello");

                //
                //
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/MusicList', arguments: {
                          "musicUrl": musicUrl,
                          "nameUrl": nameUrl
                        });
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
