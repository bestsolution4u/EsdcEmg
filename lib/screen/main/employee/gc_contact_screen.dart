import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/screen/main/webview_screen.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:flutter/material.dart';

class GCContactScreen extends StatefulWidget {
  @override
  _GCContactScreenState createState() => _GCContactScreenState();
}

class _GCContactScreenState extends State<GCContactScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChildAppbar(
                title: 'gc_contacts',
              ),
              SizedBox(height: 20,),
              ItemSelectorRow(
                title: 'gc_directory',
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: 'gc_directory', url: "url_gc_directory"),
              ),
              ItemSelectorRow(
                title: 'call_canada',
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: 'call_canada', url: "url_call_canada"),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ));
  }

  void gotoWebviewScreen({String title, String url}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WebviewScreen(title: title, url: url,),));
  }
}
