import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:relaxio/themes/colors.dart';

class Music extends StatefulWidget {
  const Music({super.key});

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
  final auth = FirebaseAuth.instance;
  late AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  late var musicObject;
  late String id;
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
    //nameObject = Get.arguments ?? ['nameUrl'];

    //id = musicObject['musicUrl'].split("/")[5];
    print("diano");
    //print(id);
    print(musicObject);

    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    //print("hello\n");

    try {
      audioSources = [];
      for (String url in musicObject['musicUrl']) {
        //print(Uri.parse(url));
        // id = url.split("/")[5];
        // print("id" + id);
        // audioSources.add(AudioSource.uri(
        //     Uri.parse("https://docs.google.com/uc?export=download&id=$id")));
        audioSources.add(AudioSource.uri(Uri.parse(url)));
        print("i am audio");
        print(audioSources);
      }

      /*
      nameSources = [];
      for (name in nameObject['nameUrl']) {
        nameSources.add(name);
        //print("name");
        //print(nameObject['nameUrl']);
        print(nameSources);
      }*/

      //print("audiosources\n");
      //print(nameSources);

      final playlist = ConcatenatingAudioSource(
        // Start loading next item just before reaching it
        useLazyPreparation: true,
        // Customise the shuffle algorithm
        shuffleOrder: DefaultShuffleOrder(),
        // Specify the playlist items
        children: audioSources,
      );
      //print("playlist\n");
      //print(playlist);

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          children: [
            // Back Button
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.035, top: screenWidth * 0.035),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: secondaryColor, // Circle background color
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        // Icons.arrow_back,
                        size: 20,
                        color: Colors.white, // Back button color
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: screenHeight * 0.04,
            ),

            // MUSIC CONTAINER
            Container(
              height: screenHeight * 0.34,
              width: screenWidth * 0.74,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: Text(
                  'Music',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.1,
                    fontWeight: FontWeight.normal,
                    letterSpacing: screenWidth * 0.0125,
                  ),
                ),
              ),
            ),

            // SONG NAME & AUTHOR NAME
            SizedBox(height: screenHeight * 0.1),
            const Text(
              'Weightless', // Replace with the actual song name
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.5,
              ),
            ),
            const Text(
              'Jeff Ray', // Replace with the actual song name
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.5,
              ),
            ),

            // PLAYER BUTTONS
            SizedBox(height: screenHeight * 0.03), // Increased space
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Increased space between icons
              children: [
                CircleIconButton(
                  icon: Icons.skip_previous_rounded,
                  onPressed: () {
                    setState(() {
                      _audioPlayer.seekToPrevious();
                    });
                  },
                  iconSize: screenWidth * 0.15,
                  iconColor: secondaryColor,
                ),
                CircleIconButton(
                  icon: isPlaying
                      ? Icons.pause_circle_filled_rounded
                      : Icons.play_circle_fill_rounded,
                  onPressed: () {
                    if (isPlaying) {
                      _audioPlayer.pause();
                    } else {
                      _audioPlayer.play();
                    }
                    setState(() {
                      isPlaying = !isPlaying;
                    });
                  },
                  iconSize: screenWidth * 0.15,
                  iconColor: secondaryColor,
                ),
                CircleIconButton(
                  icon: Icons.skip_next_rounded,
                  onPressed: () {
                    setState(() {
                      _audioPlayer.seekToNext();
                    });
                  },
                  iconSize: screenWidth * 0.15,
                  iconColor: secondaryColor,
                ),
              ],
            ),

            // TIMELINE BAR
            // SizedBox(height: screenHeight * 0.05),
            StreamBuilder<Duration?>(
              stream: _audioPlayer.durationStream,
              builder: (context, snapshot) {
                final duration = snapshot.data ?? Duration.zero;
                return StreamBuilder<Duration>(
                  stream: _audioPlayer.positionStream,
                  builder: (context, snapshot) {
                    final position = snapshot.data ?? Duration.zero;
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            screenWidth * 0.075,
                            screenWidth * 0,
                            screenWidth * 0.075,
                            screenWidth * 0,
                          ),
                          child: Slider(
                            value: position.inMilliseconds.toDouble(),
                            max: duration.inMilliseconds.toDouble(),
                            onChanged: (value) {
                              _audioPlayer
                                  .seek(Duration(milliseconds: value.round()));
                            },
                            activeColor: const Color(0xFFFFDD67),
                            inactiveColor: secondaryColor,
                          ),
                        ),

                        // TIME SHOW / PLAY
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          '${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')} / ${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
                          style: TextStyle(fontSize: 16, color: secondaryColor),
                        ),

                        // STAR INSIDE A SMALL CIRCLE
                        SizedBox(height: screenHeight * 0.03),
                        Padding(
                          padding: EdgeInsets.only(right: screenWidth * 0.1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        secondaryColor, // Circle background color
                                  ),
                                  padding: const EdgeInsets.all(10.0),
                                  child: const Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.yellow, // Star color
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CircleIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double iconSize;
  final Color iconColor;

  const CircleIconButton({
    required this.icon,
    required this.onPressed,
    this.iconSize = 14.0,
    this.iconColor = Colors.blue,
  });

  @override
  State<CircleIconButton> createState() => _CircleIconButtonState();
}

class _CircleIconButtonState extends State<CircleIconButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(8.0),
      child: IconButton(
        icon: Icon(widget.icon),
        onPressed: widget.onPressed,
        iconSize: widget.iconSize,
        color: widget.iconColor,
      ),
    );
  }
}
