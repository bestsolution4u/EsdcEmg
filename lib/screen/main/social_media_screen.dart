import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/row/category_label.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:flutter/material.dart';

import 'webview_screen.dart';

class SocialMediaScreen extends StatefulWidget {
  @override
  _SocialMediaScreenState createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.lightGray,
      appBar: ESDCAppbar.generateMainAppbar(title: "Social media"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CategoryLabel(label: 'FACEBOOK'),
            ItemSelectorRow(title: 'ESDC', assetImage: 'asset/image/chat.svg', onClick: () => gotoWebviewScreen(title: 'ESDC Facebook', url: 'https://www.facebook.com/ESDC.GC/'),),
            ItemSelectorRow(title: 'Accessible Canada', assetImage: 'asset/image/chat.svg', onClick: () => gotoWebviewScreen(title: 'Accessible Canada', url: 'https://facebook.com/AccessibleGC/'),),
            ItemSelectorRow(title: 'Leaders Today', assetImage: 'asset/image/chat.svg', onClick: () => gotoWebviewScreen(title: 'Leaders Today', url: 'https://www.facebook.com/LeadersToday/'),),
            ItemSelectorRow(title: 'Senior in Canada', assetImage: 'asset/image/chat.svg', onClick: () => gotoWebviewScreen(title: 'Senior in Canada', url: 'https://www.facebook.com/pages/Seniors-in-Canada-A%C3%AEn%C3%A9s-au-Canada/1471831713076413?ref=hl'),),
            CategoryLabel(label: 'TWITTER'),
            ItemSelectorRow(title: 'ESDC', assetImage: 'asset/image/twitter.svg', onClick: () => gotoWebviewScreen(title: 'ESDC Twitter', url: 'https://twitter.com/ESDC_GC'),),
            ItemSelectorRow(title: 'Service Canada', assetImage: 'asset/image/twitter.svg', onClick: () => gotoWebviewScreen(title: 'Service Canada', url: 'https://twitter.com/ServiceCanada_E'),),
            ItemSelectorRow(title: 'Accessible Canada', assetImage: 'asset/image/twitter.svg', onClick: () => gotoWebviewScreen(title: 'Accessible Canada', url: 'https://twitter.com/AccessibleGC'),),
            CategoryLabel(label: 'YOUTUBE'),
            ItemSelectorRow(title: 'ESDC', assetImage: 'asset/image/chat.svg', onClick: () => gotoWebviewScreen(title: 'ESDC Youtube', url: 'https://www.youtube.com/user/HRSDCanada'),),
            ItemSelectorRow(title: 'Service Canada', assetImage: 'asset/image/chat.svg', onClick: () => gotoWebviewScreen(title: 'Service Canada', url: 'https://www.youtube.com/user/ServiceCanadaE/videos'),),
            CategoryLabel(label: 'INSTAGRAM'),
            ItemSelectorRow(title: 'ESDC', assetImage: 'asset/image/chat.svg', onClick: () => gotoWebviewScreen(title: 'ESDC Instagram', url: 'https://www.instagram.com/esdc.edsc/'),),
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
