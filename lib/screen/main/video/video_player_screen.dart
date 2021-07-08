import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/model/youtube_video_model.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    muted = false;
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    )..addListener(listener);
  }

  void listener() {
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: "Video player screen loaded",
      value: "Video player screen loaded",
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: YoutubePlayer(
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
