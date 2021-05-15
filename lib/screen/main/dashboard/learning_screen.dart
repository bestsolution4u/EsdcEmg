import 'package:esdc_emg/screen/main/webview_screen.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:flutter/material.dart';

class LearningScreen extends StatefulWidget {
  @override
  _LearningScreenState createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChildAppbar(
              title: "learning",
            ),
            SizedBox(height: 20,),
            ItemSelectorRow(
              title: 'saba_cloud',
              assetImage: 'asset/image/chat.svg',
              onClick: () => gotoWebviewScreen(
                  title: "saba_cloud",
                  url: "url_saba_cloud"
              ),
            ),
            ItemSelectorRow(
              title: 'canada_school_service',
              assetImage: 'asset/image/chat.svg',
              onClick: () => gotoWebviewScreen(
                  title: "canada_school_service",
                  url: 'url_canada_school_service'),
            ),
            ItemSelectorRow(
              title: 'gc_campus',
              assetImage: 'asset/image/chat.svg',
              onClick: () => gotoWebviewScreen(
                  title: "gc_campus",
                  url: 'url_gc_campus'
              ),
            ),
            ItemSelectorRow(
              title: 'open_learning',
              assetImage: 'asset/image/chat.svg',
              onClick: () => gotoWebviewScreen(
                  title: "open_learning",
                  url: 'url_open_learning'
              ),
            ),
            ItemSelectorRow(
              title: 'gc_infobase',
              assetImage: 'asset/image/chat.svg',
              onClick: () => gotoWebviewScreen(
                  title: "gc_infobase",
                  url: "url_gc_infobase"
              ),
            ),
          ],
        ),
      ),
    );
  }

  void gotoWebviewScreen({String title, String url}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WebviewScreen(title: title, url: url,),));
  }
}
