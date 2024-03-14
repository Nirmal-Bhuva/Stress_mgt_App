// // Copyright 2013 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// // ignore_for_file: public_member_api_docs

// /// An example of using the plugin, controlling lifecycle and playback of the
// /// video.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relaxio/themes/colors.dart';
import 'package:relaxio/utils/utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class video extends StatefulWidget {
  const video({super.key});

  @override
  State<video> createState() => _videoState();
}

class _videoState extends State<video> {
  final auth = FirebaseAuth.instance;

  late var youtubeObject;
  late var videoID;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    youtubeObject = Get.arguments ?? ['videoUrl'];
    youtubeObject = Get.arguments ?? ['videoName'];
    youtubeObject = Get.arguments ?? ['videoContent'];

    print(youtubeObject);
    videoID = YoutubePlayer.convertUrlToId(youtubeObject["videoUrl"]);
    print("kem");
    print(videoID);
    _controller = YoutubePlayerController(
      initialVideoId: videoID,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );

    //captionLanguage:
    //isLive: true,
    //mute: ,
    //controlsVisibleAtStart:,
    //disableDragSeek:  ,
    //enableCaption: ,
    //forceHD: ,
    //showLiveFullscreenButton: true,

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Power.background,
        title: Text('Home Screen'),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Get.toNamed('/LoginScreen');
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              icon: Icon(Icons.logout_outlined)),
          SizedBox(width: 10)
        ],
      ),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
        // onReady: () {
        //   _controller.addListener(listener);
        // },
      ),
    );
  }
}
