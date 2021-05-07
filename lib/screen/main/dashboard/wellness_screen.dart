import 'package:esdc_emg/screen/main/webview_screen.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:flutter/material.dart';

class WellnessScreen extends StatefulWidget {
  @override
  _WellnessScreenState createState() => _WellnessScreenState();
}

class _WellnessScreenState extends State<WellnessScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChildAppbar(
            title: "wellness",
          ),
          SizedBox(height: 20,),
          ItemSelectorRow(
            title: 'employ_assistance_program',
            assetImage: 'asset/image/chat.svg',
            onClick: () => gotoWebviewScreen(
                title: "employ_assistance_program",
                url: 'url_employ_assistance_program'),
          ),
          ItemSelectorRow(
            title: 'life_speak',
            assetImage: 'asset/image/chat.svg',
            onClick: () => gotoWebviewScreen(
              title: "life_speak",
              url: "url_life_speak"
            ),
          ),
        ],
      ),
    ));
  }

  void gotoWebviewScreen({String title, String url}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WebviewScreen(title: title, url: url,),));
  }
}
