import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/model/video_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoHubItem extends StatefulWidget {

  final VideoModel video;

  VideoHubItem({this.video});

  @override
  _VideoHubItemState createState() => _VideoHubItemState();
}

class _VideoHubItemState extends State<VideoHubItem> {

  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: true,
        enableCaption: false,
      ),
    )..addListener(listener);
  }

  void listener() {
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                child: Center(
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressColors: ProgressBarColors(
                      playedColor: Colors.white,
                      handleColor: Styles.bgGrey,
                    ),),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.video.pubLogo, width: 32, height: 32, fit: BoxFit.cover),
            SizedBox(width: 10,),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.video.title, style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis,),
                    Text(widget.video.publisher + ", " + widget.video.time, style: TextStyle(color: Colors.grey, fontSize: 10),)
                  ],
                )
            ),
            SizedBox(width: 10,),
            SvgPicture.asset(
              'asset/image/youtube-selected.svg',
              allowDrawingOutsideViewBox: true,
              width: 25,
              height: 25,
              color: Colors.red,
            ),
          ],
        )
      ],
    );
  }
}
