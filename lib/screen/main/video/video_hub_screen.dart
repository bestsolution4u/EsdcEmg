import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/row/video_hub_item.dart';
import 'package:flutter/material.dart';

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
                itemBuilder: (context, index) => VideoHubItem(video: Globals.VIDEOS[index]),
                separatorBuilder: (context, index) => SizedBox(height: 20,),
                itemCount: Globals.VIDEOS.length,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            )
          ],
        ),
      ),
    );
  }
}
