import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/model/youtube_video_model.dart';
import 'package:esdc_emg/screen/main/video/video_player_screen.dart';
import 'package:esdc_emg/util/message_util.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:flutter/material.dart';

class BannerItem extends StatefulWidget {

  final YoutubeVideoModel video;

  BannerItem({this.video});

  @override
  _BannerItemState createState() => _BannerItemState();
}

class _BannerItemState extends State<BannerItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
      child: RippleComponent(
        onClick: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerScreen(video: widget.video,),));
        },
        borderRadius: 6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Stack(
                children: <Widget>[
                  Image.network(widget.video.thumbnail, fit: BoxFit.cover, width: double.infinity, height: 160),
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: Text(
                          MessageUtils.parseISO8601(widget.video.duration),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              height: 1
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Text(
              widget.video.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Styles.primaryColor,
                  fontSize: 16,
                  height: 1,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 5,),
            Text(
              widget.video.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Styles.primaryColor,
                  fontSize: 12,
                  height: 1),
            ),
          ],
        ),
      ),
    );
  }
}
