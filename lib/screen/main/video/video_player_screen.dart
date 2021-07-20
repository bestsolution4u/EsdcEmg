import 'package:chewie/chewie.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/model/youtube_video_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {

  final YoutubeVideoModel video;

  VideoPlayerScreen({this.video});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  YoutubePlayerController _controller;
  bool muted;

  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(
        'http://www.youtube.com/watch?v=${widget.video.id}');
    videoPlayerController.initialize().then((value) {
      setState(() {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          autoPlay: true,
          looping: true,
        );
      });
    });


    /*muted = false;
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
        captionLanguage: AppLocalization.currentLanguage
      ),
    )..addListener(listener);*/
  }

  void listener() {
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: "Video player screen loaded",
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: /*YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressColors: ProgressBarColors(
                  playedColor: Colors.white,
                  handleColor: Styles.bgGrey,
                ),
                bottomActions: [
                  const SizedBox(width: 14.0),
                  CurrentPosition(),
                  const SizedBox(width: 8.0),
                  ProgressBar(
                    isExpanded: true,
                  ),
                  RemainingDuration(),
                  const PlaybackSpeedButton(),
                  FullScreenButton(),
                  IconButton(icon: Icon(muted ? Icons.volume_mute : Icons.volume_off, color: Colors.white,), onPressed: () {
                    if (muted) {
                      _controller.unMute();
                    } else {
                      _controller.mute();
                    }
                    setState(() {
                      muted = !muted;
                    });
                  })
                ],
              )*/ AspectRatio(
                aspectRatio: videoPlayerController.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Chewie(
                      controller: chewieController,
                    ),
                    ClosedCaption(
                      text: videoPlayerController.value.caption.text,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                right: 10,
                top: 50,
                child: IconButton(
                  icon: Icon(Icons.close, size: 24, color: Colors.white,),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ))
          ],
        ),
      ),
    );
  }
}
