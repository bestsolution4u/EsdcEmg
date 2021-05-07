import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/row/category_label.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:flutter/material.dart';

import '../webview_screen.dart';

class SocialMediaScreen extends StatefulWidget {
  @override
  _SocialMediaScreenState createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.lightGray,
      appBar: ESDCAppbar.generateMainAppbar(title: "title_soci_medi", context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CategoryLabel(label: 'facebook'),
            ItemSelectorRow(title: 'esdc', assetImage: 'asset/image/chat.svg', onClick: () => gotoWebviewScreen(title: 'esdc_facebook', url: 'url_esdc_facebook'),),
            ItemSelectorRow(title: 'access_canada', assetImage: 'asset/image/chat.svg', onClick: () => gotoWebviewScreen(title: 'access_canada', url: 'url_access_canada'),),
            ItemSelectorRow(title: 'leader_today', assetImage: 'asset/image/chat.svg', onClick: () => gotoWebviewScreen(title: 'leader_today', url: 'url_leader_today'),),
            ItemSelectorRow(title: 'senior_canada', assetImage: 'asset/image/chat.svg', onClick: () => gotoWebviewScreen(title: 'senior_canada', url: 'url_senior_canada'),),
            CategoryLabel(label: 'twitter'),
            ItemSelectorRow(title: 'esdc', assetImage: 'asset/image/twitter.svg', onClick: () => gotoWebviewScreen(title: 'esdc_twitter', url: 'url_esdc_twitter'),),
            ItemSelectorRow(title: 'service_canada', assetImage: 'asset/image/twitter.svg', onClick: () => gotoWebviewScreen(title: 'service_canada', url: 'url_service_canada'),),
            ItemSelectorRow(title: 'access_canada', assetImage: 'asset/image/twitter.svg', onClick: () => gotoWebviewScreen(title: 'access_canada', url: 'url_access_canada_twitter'),),
            CategoryLabel(label: 'you_tube'),
            ItemSelectorRow(title: 'esdc', assetImage: 'asset/image/chat.svg', onClick: () => gotoWebviewScreen(title: 'esdc_youtube', url: 'url_esdc_youtube'),),
            ItemSelectorRow(title: 'service_canada', assetImage: 'asset/image/chat.svg', onClick: () => gotoWebviewScreen(title: 'service_canada', url: 'url_service_canada_youtube'),),
            CategoryLabel(label: 'instagram'),
            ItemSelectorRow(title: 'esdc', assetImage: 'asset/image/chat.svg', onClick: () => gotoWebviewScreen(title: 'esdc_instagram', url: 'url_esdc_instagram'),),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }

  void gotoWebviewScreen({String title, String url}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WebviewScreen(title: title, url: url,),));
  }
}
