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
    return SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChildAppbar(
                title: "Learning",
              ),
              SizedBox(height: 20,),
              ItemSelectorRow(
                title: 'Canada School of Public Service',
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(
                    title: "Canada School of Public Service",
                    url: "https://www.csps-efpc.gc.ca/index-eng.aspx"),
              ),
              ItemSelectorRow(
                title: 'GC Campus',
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(
                    title: "GC Campus",
                    url: "https://www.csps-efpc.gc.ca/gccampus/index-eng.aspx"
                ),
              ),
              ItemSelectorRow(
                title: 'ESDC - SABA Cloud',
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(
                    title: "ESDC - SABA Cloud",
                    url: "https://esdc.sabacloud.com/Saba/Web_wdk/CA1PRD0006/index/prelogin.rdf"
                ),
              ),
              ItemSelectorRow(
                title: 'GC Infobase',
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(
                    title: "GC Infobase",
                    url: "https://www.tbs-sct.gc.ca/ems-sgd/edb-bdd/index-eng.html"
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
