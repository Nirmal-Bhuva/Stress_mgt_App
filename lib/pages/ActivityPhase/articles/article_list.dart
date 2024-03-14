import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:relaxio/themes/colors.dart';

late Object article_data;

class ArticleList extends StatefulWidget {
  const ArticleList({super.key});

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  late var article_name;
  late var article_content;
  late String name;
  late String content;

  late List nameSources = [];
  late List contentSources = [];

  @override
  void initState() {
    super.initState();

    //_audioPlayer = AudioPlayer();
    article_name = Get.arguments ?? ['article_name'];
    article_content = Get.arguments ?? ['article_content'];

    print("article_catego");

    nameSources = [];
    for (name in article_name["article_name"]) {
      nameSources.add(name);
    }
    contentSources = [];
    for (content in article_content["article_content"]) {
      contentSources.add(content);
    }
    print(article_content["article_content"]);
    print(contentSources);
    //print(article_category["article_category"]);

    // load_data(article_category["article_category"])
    //     .then((value) => (article_data = value!));
  }

  // Future<Object?> load_data(article_category) async {
  //   //print(article_category);
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection("article")
  //       .where("article_category_id", isEqualTo: article_category)
  //       .get();
  //   //print(querySnapshot.docs[0].data());
  //   return querySnapshot.docs[0].data()!;
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    //_audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print(article_data);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Power.cardsColor.first,
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            // TOP MUSIC Container
            Container(
              width: 400,
              height: 320,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(70.0),
                  bottomRight: Radius.circular(70.0),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // MUSIC TEXT in MIDDLE
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Article",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 2.5,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 65,
                  ),
                  // QUOTE in the BOTTOM of the CONTAINER
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "The most-played relaxation music,\n updated every day.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // PLAY BUTTON background
            SizedBox(
              height: 30,
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: nameSources.length,
              itemBuilder: (context, index) {
                print(nameSources[index]);
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      print("hello");
                      //print(musicObject['musicUrl']);
                      Get.toNamed('/Article', arguments: {
                        "article_content": article_content["article_content"]
                            [index],
                        "article_name": article_name["article_name"][index],
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/3.png',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${article_name['article_name'][index]}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuButton<String>(
                            itemBuilder: (context) => [
                              PopupMenuItem<String>(
                                value: 'option1',
                                child: Text('Option 1'),
                              ),
                              PopupMenuItem<String>(
                                value: 'option2',
                                child: Text('Option 2'),
                              ),
                              PopupMenuItem<String>(
                                value: 'option3',
                                child: Text('Option 3'),
                              ),
                            ],
                            icon: Icon(Icons.more_horiz_rounded),
                            onSelected: (value) {
                              // Handle menu item selection
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )

            /* FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('article')
                    .where("article_category_id",
                        isEqualTo: article_category["article_category"])
                    .get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<DocumentSnapshot> data = snapshot.data!.docs;

                    List<int> fieldLengthList = [];
                    late List articleNameList = [];

                    for (DocumentSnapshot document in data) {
                      Map<String, dynamic> documentData =
                          document.data() as Map<String, dynamic>;

                      // Assuming 'fieldName' is the field for which you want to find the length
                      if (documentData.containsKey('article_name')) {
                        List<dynamic> fieldArray = documentData['article_name'];

                        int fieldLength = fieldArray.length;
                        fieldLengthList.add(fieldLength);
                        print(
                            'Length of fieldName array in this document: $fieldLength');

                        var articleName = documentData['article_name'];
                        //print(articleName);
                        for (name in articleName) {
                          articleNameList.add(name);
                          print(articleNameList);
                        }
                      }
                    }

                    print("data");
                    print(data);
                    // var article_c_id = data[index].get('article_category_id');

                    //var article_name = data[index].get('article_name');

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        //var article_content =
                        // data[index].get('article_content');
                        //var imageUrl = data[index].get('image_url');
                        //var article_name = data[index].get('article_name');
                        //print(article_content[index]);
                        print("article_name[index]");
                        print(articleNameList.length);

                        var article = data[index].get('article_name');
                        print(article);

                        //articleNames.add(data[index].get('article_name'));
                        //print("object");
                        //print(articleNames);

                        //print(article_name);

                        Map<String, dynamic> documentData =
                            data[index].data() as Map<String, dynamic>;

                        // Check if 'article_name' field exists before accessing it
                        if (documentData.containsKey('article_name')) {
                          var articleName = documentData['article_name'];

                          // Access the actual value at the current index
                          print(
                              "article_name[$index]: $articleName[$index]"); // Print for verification

                          return InkWell(
                            onTap: () {
                              // print("hello");
                              // print(musicObject['musicUrl']);
                              // Get.toNamed('/Article', arguments: {
                              //   "article_name": article_name["article_name"],

                              //   // Wrap it in a List if needed
                              // "article_content":
                              //     article_content["article_content"]
                              // });
                            },
                            child: Container(
                              margin: EdgeInsets.all(screenWidth * 0.02),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/3.png',
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /* Text(
                                        '${data[index].get('article_name')}',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),*/
                                      ],
                                    ),
                                  ),
                                  PopupMenuButton<String>(
                                    itemBuilder: (context) => [
                                      PopupMenuItem<String>(
                                        value: 'option1',
                                        child: Text('Option 1'),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'option2',
                                        child: Text('Option 2'),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'option3',
                                        child: Text('Option 3'),
                                      ),
                                    ],
                                    icon: Icon(Icons.more_horiz_rounded),
                                    onSelected: (value) {
                                      // Handle menu item selection
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ); /*ListTile(
                            title: Column(
                              children: [
                                //if (data != articleNameList.length)
                                Text(articleNameList[0]),
                                Text(articleNameList[1]),
                                Text(articleNameList[2]),
                                Text(articleNameList[3]),
                              ],
                            ),
                          );*/
                        } else {
                          // Handle the case where 'article_name' is missing
                          return Text('Article name unavailable');
                        }
                        /*InkWell(
                          onTap: () {
                            // print("hello");
                            // print(musicObject['musicUrl']);
                            // Get.toNamed('/Article', arguments: {
                            //   "article_name": article_name["article_name"],

                            //   // Wrap it in a List if needed
                            // "article_content":
                            //     article_content["article_content"]
                            // });
                          },
                          child: Container(
                            margin: EdgeInsets.all(screenWidth * 0.02),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/3.png',
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${data[index].get('article_name')}',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuButton<String>(
                                  itemBuilder: (context) => [
                                    PopupMenuItem<String>(
                                      value: 'option1',
                                      child: Text('Option 1'),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'option2',
                                      child: Text('Option 2'),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'option3',
                                      child: Text('Option 3'),
                                    ),
                                  ],
                                  icon: Icon(Icons.more_horiz_rounded),
                                  onSelected: (value) {
                                    // Handle menu item selection
                                  },
                                ),
                              ],
                            ),
                          ),
                        );*/
                      },
                    );
                  }
                }),*/
          ],
        )),
      ),
    );
  }
}
