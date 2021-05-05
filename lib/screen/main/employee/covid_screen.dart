import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/screen/main/webview_screen.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:flutter/material.dart';

class CovidScreen extends StatefulWidget {
  @override
  _CovidScreenState createState() => _CovidScreenState();
}

class _CovidScreenState extends State<CovidScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChildAppbar(
                title: translate('title_covid'),
              ),
              SizedBox(height: 20,),
              ItemSelectorRow(
                title: translate('active_screening'),
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: translate('active_screening'), url: "https://www.canada.ca/en/employment-social-development/screening-tool.html"),
              ),
              ItemSelectorRow(
                title: translate('info_about_covid'),
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: translate('info_about_covid'), url: "https://www.canada.ca/en/government/publicservice/covid-19.html"),
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
