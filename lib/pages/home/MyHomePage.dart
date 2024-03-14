import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:relaxio/pages/home/widgets/article_container.dart';
import 'package:relaxio/pages/home/widgets/circle.dart';
import 'package:relaxio/pages/home/widgets/music_container.dart';
import 'package:relaxio/pages/home/widgets/video_container.dart';
import 'package:relaxio/themes/colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final auth = FirebaseAuth.instance;
  late AudioPlayer _audioPlayer;
  late String image;
  late String url;
  //late String name;

  @override
  void initState() {
    super.initState();
  }

  double screenWidth = 0;
  double screenHeight = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // TOP BAR PANEL
            SizedBox(
              height: screenHeight * 0.015,
            ),
            Row(
              children: [
                // USER PROFILE / MENU
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.03, 0, 0, 0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: screenWidth * 0.135,
                        height: screenHeight * 0.063,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[100],
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                ),

                // USER NAME
                const SizedBox(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Text(
                      'Hemil',
                      style: TextStyle(
                        fontSize: 25,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),

                // LOG BUTTON
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.45, 0, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        //Navigator.push(
                        //context,
                        //MaterialPageRoute(builder: (context) => const LogScreen()),
                        //);
                      },
                      child: Container(
                        width: screenWidth * 0.135,
                        height: screenHeight * 0.063,
                        decoration: BoxDecoration(
                          color: const Color(0xFFB5E99D),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // BODY --------------------
            SizedBox(
              height: screenHeight * 0.035,
            ),
            Container(
              width: screenWidth * 0.92,
              height: screenHeight * 0.26,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Center(
                child: Text(
                  'Scroll View\n of Quotes',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    letterSpacing: 3,
                  ),
                ),
              ),
            ),

            // CIRCLE POP's
            SizedBox(
              height: screenHeight * 0.035,
            ),

            Container(
              child: MyCircle(
                name: '/',
              ),
            ),

            // MUSIC PANEL
            SizedBox(
              height: screenHeight * 0.04,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Music',
                  style: TextStyle(
                    fontSize: 25,
                    letterSpacing: 5,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),

            Container(
              child: audio(
                routeName: '/',
              ),
            ),

            // VIDEOs PANEL
            SizedBox(
              height: screenHeight * 0.04,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Video',
                  style: TextStyle(
                    fontSize: 25,
                    letterSpacing: 5,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),

            Container(
              child: video(
                routeName: '/',
              ),
            ),

            // ARTICLES PANEL
            SizedBox(
              height: screenHeight * 0.04,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Articles',
                  style: TextStyle(
                    fontSize: 25,
                    letterSpacing: 5,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),

            Container(
              child: article(
                routeName: '/',
              ),
            ),

            SizedBox(
              height: screenHeight * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
