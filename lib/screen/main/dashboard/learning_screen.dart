import 'package:esdc_emg/screen/main/webview_screen.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:flutter/material.dart';

import '../../../config/style.dart';
import '../../../widget/appbar/child_image_appbar.dart';
import '../../../widget/button/border_item_selector.dart';

class LearningScreen extends StatefulWidget {
  @override
  _LearningScreenState createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.darkBlue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChildImageAppbar(
              title: "learning",
              icon: 'asset/image/icon-learning.svg',
            ),
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                      child: BorderItemSelector(
                    title: 'saba_cloud',
                    icon: 'asset/image/icon-nav-saba.svg',
                    onClick: () => gotoWebviewScreen(
                        title: "saba_cloud",
                        url: 'url_saba_cloud'),
                  )),
                  SizedBox(width: 20,),
                  Expanded(
                      flex: 1,
                      child: BorderItemSelector(
                        title: 'canada_school_service',
                        icon: 'asset/image/icon-nav-canadaschool.svg',
                        onClick: () => gotoWebviewScreen(
                            title: "canada_school_service",
                            url: 'url_canada_school_service'),
                      )),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      flex: 1,
                      child: BorderItemSelector(
                        title: 'gc_campus',
                        icon: 'asset/image/icon-nav-gccampus.svg',
                        onClick: () => gotoWebviewScreen(
                            title: "gc_campus",
                            url: 'url_gc_campus'),
                      )),
                  SizedBox(width: 20,),
                  Expanded(
                      flex: 1,
                      child: BorderItemSelector(
                        title: 'gc_infobase',
                        icon: 'asset/image/icon-nav-gcinfobase.svg',
                        onClick: () => gotoWebviewScreen(
                            title: "gc_infobase",
                            url: 'url_gc_infobase'),
                      )),
                ],
              ),
            ),
            /*ItemSelectorRow(
              title: 'open_learning',
              assetImage: 'asset/image/chat.svg',
              onClick: () => gotoWebviewScreen(
                  title: "open_learning",
                  url: 'url_open_learning'
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  void gotoWebviewScreen({String title, String url}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WebviewScreen(title: title, url: url,),));
  }
}
