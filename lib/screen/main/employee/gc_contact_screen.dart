import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/screen/main/dashboard/learning_screen.dart';
import 'package:esdc_emg/screen/main/dashboard/wellness_screen.dart';
import 'package:esdc_emg/screen/main/webview_screen.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/row/category_label.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:flutter/material.dart';

import '../pdfviewer_screen.dart';
import 'gc_contact_screen.dart';
import 'pay_benefit_screen.dart';

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
                title: translate('gc_contacts'),
              ),
              SizedBox(height: 20,),
              ItemSelectorRow(
                title: translate('gc_directory'),
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: translate('gc_directory'), url: "https://geds-sage.gc.ca/en/GEDS/?pgid=002"),
              ),
              ItemSelectorRow(
                title: translate('call_canada'),
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: translate('call_canada'), url: "https://www.canada.ca/en/contact/contact-1-800-o-canada.html"),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ));
  }

  String translate(String key) {
    return AppLocalization.of(context).trans(key);
  }

  void gotoWebviewScreen({String title, String url}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WebviewScreen(title: title, url: url,),));
  }
}
