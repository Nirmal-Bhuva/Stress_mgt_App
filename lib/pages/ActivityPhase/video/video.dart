// // // // Copyright 2013 The Flutter Authors. All rights reserved.
// // // // Use of this source code is governed by a BSD-style license that can be
// // // // found in the LICENSE file.

// // // // ignore_for_file: public_member_api_docs

// // // /// An example of using the plugin, controlling lifecycle and playback of the
// // /// video.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relaxio/themes/colors.dart';
import 'package:relaxio/utils/utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  final auth = FirebaseAuth.instance;

  late var videoUrl;
  late var videoName;
  late var videoContent;
  late var videoID;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    videoUrl = Get.arguments ?? ['videoUrl'];
    videoName = Get.arguments ?? ['videoName'];
    videoContent = Get.arguments ?? ['videoContent'];

    print(videoUrl);
    videoID = YoutubePlayer.convertUrlToId(videoUrl["videoUrl"]);
    print("kem");
    print(videoID);
    _controller = YoutubePlayerController(
      initialVideoId: videoID,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        //mute: true,
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
  void dispose() {
    _controller.dispose();
    super.dispose();
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
        liveUIColor: Colors.amber,
        showVideoProgressIndicator: true,
        bottomActions: [
          CurrentPosition(),
          ProgressBar(
            isExpanded: true,
            colors: const ProgressBarColors(
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            ),
          ),
        ],
        onReady: () => debugPrint('Ready'),
      ),
    );
  }
}
