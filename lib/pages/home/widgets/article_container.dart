import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relaxio/themes/colors.dart';

class article extends StatefulWidget {
  article({
    super.key,
    required this.routeName,
  });

  final String routeName;

  @override
  State<article> createState() => _articleState();
}

class _articleState extends State<article> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fetchData();
  }

  // Future<void> fetchData() async {
  //   try {
  //     // Fetch the document from collectionA
  //     DocumentSnapshot collectionADoc =
  //         await firestore.collection('article_category').doc().get();
  //     print(collectionADoc);

  //     // Get the reference field
  //     DocumentReference referenceToCollectionB =
  //         collectionADoc['category_name'];

  //     // Fetch the document from collectionB using the reference
  //     DocumentSnapshot collectionBDoc = await referenceToCollectionB.get();

  //     // Access the data in the referenced document
  //     print('Data from collectionB: ${collectionBDoc.data()}');
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //   }
  // }

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
        future: FirebaseFirestore.instance.collection('article').get(),
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
                var article_content = data[index].get('article_content');
                var article_name = data[index].get('article_name');
                var imageUrl = data[index].get('imageUrl');

                //var article_category = data[index].get("article_category_id");
                //var article_category = data[index].get("category_name");
                // for (imagename in imageUrl) {
                //   image1.add(imagename);
                // }
                print("category");
                //print(article_category[""]);
                //print("article_title");
                //print(article_content);
                //print(article_title);

                //print("hello i am");
                //print(name1);

                //
                //
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/ArticleList', arguments: {
                          "article_name": article_name,
                          "article_content": article_content,
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
