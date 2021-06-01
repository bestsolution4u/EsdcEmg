import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/model/video_model.dart';
import 'package:esdc_emg/screen/main/video/video_player_screen.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VideoHubItem extends StatefulWidget {

  final VideoModel video;

  VideoHubItem({this.video});

  @override
  _VideoHubItemState createState() => _VideoHubItemState();
}

class _VideoHubItemState extends State<VideoHubItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RippleComponent(
          onClick: () {
            /*Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerScreen(video: widget.video,),));*/
          },
          child: Card(
            color: Styles.bgGrey,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  child: Center(
                    child: Image.network(widget.video.thumbnail, width: double.infinity, height: double.infinity, fit: BoxFit.cover,),
                  ),
                ),
                /*Positioned(
                    bottom: 0,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.black.withOpacity(0.8)
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.remove_red_eye, color: Colors.white, size: 14,),
                          SizedBox(width: 4,),
                          Text('385', style: TextStyle(fontSize: 12, color: Colors.white),),
                          SizedBox(width: 6,),
                          Icon(Icons.chat_bubble, color: Colors.white, size: 12,),
                          SizedBox(width: 4,),
                          Text('13', style: TextStyle(fontSize: 12, color: Colors.white),),
                        ],
                      ),
                    )
                )*/
              ],
            ),
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
