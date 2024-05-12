import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
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
  String quoteText = '';
  String? randomQuote = '';
  List<String> quotes = [];

  double screenWidth = 0;
  double screenHeight = 0;

  // void fetchQuoteFromFirestore() async {
  //   // Assuming you have a 'quotes' collection in Firestore with documents containing a 'quote' field
  //   CollectionReference quotesCollection =
  //       FirebaseFirestore.instance.collection('daily_quotes');
  //   QuerySnapshot querySnapshot = await quotesCollection.get();
  //   print("querysnapshot" + querySnapshot.toString());

  //   if (querySnapshot.docs.isNotEmpty) {
  //     querySnapshot.docs.forEach((doc) {
  //       var quoteText = doc[
  //           'text']; // Access the 'text' field directly from the DocumentSnapshot
  //       print("quotetext" + quoteText);
  //       if (quoteText != null) {
  //         setState(() {
  //           quotesList.add(quoteText); // Add the fetched text to quotesList
  //           print("listdhoom" + quotesList.toString());
  //         });

  //         print("quotelist" + quotesList.toString());
  //       }
  //     });
  //     // if (quotesList.isNotEmpty) {
  //     //   currentQuoteIndex = (currentQuoteIndex + 1) % quotesList.length;
  //     //   print("quoteindex" + currentQuoteIndex.toString());
  //     // }
  //   }
  // }

  Future<List<String>> fetchQuotes() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('daily_quotes').get();

    //List<String> quotes = [];
    querySnapshot.docs.forEach((doc) {
      quotes.add(doc['text']);
    });
    print("quotes");
    print("quotes" + quotes.toString());

    return quotes;
  }

  void displayRandomQuote() {
    fetchQuotes().then((quotes) {
      if (quotes.isNotEmpty) {
        Random random = Random();
        int randomIndex = random.nextInt(quotes.length);
        print("randomindex" + randomIndex.toString());
        randomQuote = quotes[randomIndex];

        // Display or use the random quote here
        print("randomQuote" + randomQuote.toString());

        // Schedule the next random quote after 24 hours
        Future.delayed(Duration(seconds: 50000), displayRandomQuote);
        setState(() {
          quoteText = randomQuote.toString();
        });
      }
    });
  }

//   void startTimer() {
//     const duration = Duration(seconds: 86400); // Timer duration set to 24 hours
//     Timer.periodic(duration, (timer) {
//       if (quotesList.isNotEmpty) {
//         print("listdoom2");
//         print("list2" + quotesList.toString());
//         // Pick a random quote from quotesList
//         int randomIndex = Random().nextInt(quotesList.length);
//         String randomQuote = quotesList[randomIndex];
//         print("randomquote" + randomQuote);

//         // Update quoteText with the randomly selected quote
//         setState(() {
//           quoteText = randomQuote;
//         });
//       }
//     });
//}

  @override
  void initState() {
    super.initState();
    fetchQuotes();
    displayRandomQuote();
    //fetchQuoteFromFirestore(); // Fetch quote initially when the widget is first built
    //startTimer(); // Start the timer to fetch quotes periodically
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _audioPlayer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // displayRandomQuote();
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
                      onTap: () {
                        Get.toNamed('/Profile');
                      },
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

                        Get.toNamed('/LogScreen1');
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
              child: Center(
                child: Text(
                  "${randomQuote}", // Display 'Loading...' while fetching data initially

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
