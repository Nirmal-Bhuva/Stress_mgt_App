import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Article extends StatefulWidget {
  const Article({super.key});

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  final auth = FirebaseAuth.instance;
  late var article_name;
  late var article_content;

  //late var article_title;

  late List nameSources_length = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //_audioPlayer = AudioPlayer();
    article_name = Get.arguments ?? ['article_name'];
    //article_title = Get.arguments ?? ['article_title'];
    article_content = Get.arguments ?? ['article_content'];

    print(article_name["article_name"]);
    print(article_content["article_content"]);

    // _fetchArticle_name();

    //print(musicObject['musicUrl']);
    //print(musicObject['musicUrl']);
    //print(nameObject['nameUrl']);
    //print("diano");
  }

  // Future<void> _fetchArticle_name() async {
  //   await for (var url in article_name['article_name']) {
  //     nameSources_length.add(url);
  //     print("i am audio");
  //     print(nameSources_length);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        SizedBox(height: 100),
        Text(article_name["article_name"]),
        SizedBox(height: 20),
        Text(article_content["article_content"]),
      ])),
      //     Material(
      //   color: Colors.transparent,
      //   child: InkWell(
      //     child: Container(
      //       margin: EdgeInsets.all(8.0),
      //       child: Row(
      //         children: [
      //           ClipRRect(
      //             borderRadius: BorderRadius.circular(8.0),
      //             child: Image.asset(
      //               'assets/3.png',
      //               width: 60,
      //               height: 60,
      //               fit: BoxFit.cover,
      //             ),
      //           ),
      //           SizedBox(width: 16.0),
      //           Expanded(
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   '${article_name['article_name']}',
      //                   style: TextStyle(
      //                     fontSize: 16.0,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 ),
      //                 Text(
      //                   '${article_content['article_content']}',
      //                   style: TextStyle(
      //                     fontSize: 16.0,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
