import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:relaxio/themes/colors.dart';

class MusicList extends StatefulWidget {
  const MusicList({super.key});

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  bool loading = false;
  final auth = FirebaseAuth.instance;
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  late var musicObject;
  late var nameObject;
  late String name;

  late List<AudioSource> audioSources = [];
  late List nameSources = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _audioPlayer = AudioPlayer();
    musicObject = Get.arguments ?? ['musicUrl'];
    nameObject = Get.arguments ?? ['nameUrl'];

    //print(musicObject['musicUrl']);
    //print(musicObject['musicUrl']);
    print("nameobject[nameurl]");
    print(nameObject['nameUrl']);
    //print("diano");

    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    //print("hello\n");

    try {
      audioSources = [];
      for (String url in musicObject['musicUrl']) {
        audioSources.add(AudioSource.uri(Uri.parse(url)));
        print("i am audio");
        print(audioSources);
      }

      nameSources = [];
      for (name in nameObject['nameUrl']) {
        nameSources.add(name);
      }

      final playlist = ConcatenatingAudioSource(
        useLazyPreparation: true,
        shuffleOrder: DefaultShuffleOrder(),
        children: audioSources,
      );

      //print("all is weell");
      await _audioPlayer.setAudioSource(playlist,
          initialIndex: 0, initialPosition: Duration.zero);
    } catch (e) {
      print("there is an error $e");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        "Music",
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
              Container(
                width: 200,
                height: 75,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                // PLAY BUTTON
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 175,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isPlaying = !isPlaying;
                        });
                        if (isPlaying) {
                          await _audioPlayer.play();
                        } else {
                          await _audioPlayer.pause();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC9F3B5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Row(
                          children: [
                            // ICON of PLAY
                            Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.black,
                              size: 28.0,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            // PLAY TEXT
                            Text(
                              'PLAY',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                letterSpacing: 3.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Music List
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: audioSources.length,
                itemBuilder: (context, index) {
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        print("hello");
                        print(musicObject['musicUrl']);
                        Get.toNamed('/Music', arguments: {
                          "musicUrl": musicObject["musicUrl"],
                          "name": nameObject["nameUrl"]
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
                                    '${nameSources[index]}',
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
          ),
        ),
      ),
    );
  }
}
