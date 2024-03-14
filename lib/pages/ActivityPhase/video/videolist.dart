import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relaxio/pages/home/widgets/article_container.dart';
import 'package:relaxio/themes/colors.dart';

class VideoList extends StatefulWidget {
  const VideoList({super.key});

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late var video_name;
  late var video_content;
  late var video_url;
  late String? name;
  late String? content;
  late String? url;

  late List nameSources = [];
  late List contentSources = [];
  late List urlSources = [];

  @override
  void initState() {
    super.initState();

    //_audioPlayer = AudioPlayer();
    video_url = Get.arguments ?? ['videoUrl'];
    video_content = Get.arguments ?? ['videoContent'];
    video_name = Get.arguments ?? ['videoName'];

    nameSources = [];
    for (name in video_name["videoName"]) {
      nameSources.add(name);
    }
    print("hello namesources");
    print(nameSources);

    contentSources = [];
    for (content in video_content["videoContent"]) {
      contentSources.add(content);
    }
    print("hello contentsources");
    print(contentSources);

    urlSources = [];
    for (url in video_url["videoUrl"]) {
      urlSources.add(url);
    }

    print("hello urlsources");
    print(urlSources);
    //print(video_content["videoContent"]);
    //print(contentSources);
    //print(article_category["article_category"]);

    // load_data(article_category["article_category"])
    //     .then((value) => (article_data = value!));
  }

  @override
  Widget build(BuildContext context) {
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
                      "Video",
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
                      Get.toNamed('/Video', arguments: {
                        "videoUrl": video_url["videoUrl"][index],
                        "videoContent": video_content["videoContent"][index],
                        "videoName": video_name["videoName"][index],
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
                                  '${video_name['video_name'][index]}',
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
          ],
        )),
      ),
    );
  }
}
