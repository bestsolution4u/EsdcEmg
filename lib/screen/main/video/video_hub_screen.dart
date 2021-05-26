import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/model/video_model.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VideoHubScreen extends StatefulWidget {
  @override
  _VideoHubScreenState createState() => _VideoHubScreenState();
}

class _VideoHubScreenState extends State<VideoHubScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ESDCAppbar.renderMainAppbar(
          title: 'video_hub',
          icon: 'asset/image/youtube-selected.svg',
          context: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(height: 1,),
            ListView.separated(
              shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) => buildVideoItem(index),
                separatorBuilder: (context, index) => SizedBox(height: 20,),
                itemCount: Globals.VIDEOS.length,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            )
          ],
        ),
      ),
    );
  }

  Widget buildVideoItem(int index) {
    VideoModel video = Globals.VIDEOS[index];
    return RippleComponent(
      onClick: () {

      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
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
                    child: Image.network(video.thumbnail, width: double.infinity, height: double.infinity, fit: BoxFit.cover,),
                  ),
                ),
                Positioned(
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
                )
              ],
            ),
          ),
          SizedBox(height: 4,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(video.pubLogo, width: 32, height: 32, fit: BoxFit.cover),
              SizedBox(width: 10,),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(video.title, style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis,),
                      Text(video.publisher + ", " + video.time, style: TextStyle(color: Colors.grey, fontSize: 12),)
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
      ),
    );
  }
}
