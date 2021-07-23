import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
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
  bool enableCC;

  @override
  void initState() {
    super.initState();
    muted = false;
    enableCC = true;
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: enableCC,
        captionLanguage: AppLocalization.currentLanguage
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var player = YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressColors: ProgressBarColors(
        playedColor: Colors.white,
        handleColor: Styles.bgGrey,
      ),
      bottomActions: [
        SizedBox(width: 14.0),
        CurrentPosition(),
        SizedBox(width: 8.0),
        ProgressBar(
          isExpanded: true,
        ),
        RemainingDuration(),
        PlaybackSpeedButton(),
        FullScreenButton(),
        IconButton(icon: Icon(enableCC ? Icons.closed_caption : Icons.closed_caption_disabled, color: Colors.white,), onPressed: () {
          setState(() {
            enableCC = !enableCC;
            _controller = YoutubePlayerController(
              initialVideoId: widget.video.id,
              flags: YoutubePlayerFlags(
                  mute: muted,
                  autoPlay: true,
                  disableDragSeek: false,
                  loop: false,
                  isLive: false,
                  forceHD: false,
                  enableCaption: enableCC,
                  captionLanguage: AppLocalization.currentLanguage
              ),
            );
          });
        }),
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
    );
    print('---------------------- build player -------------------');
    print(enableCC);
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: "Video player screen loaded",
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: player,
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
