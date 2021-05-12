import 'package:esdc_emg/screen/main/webview_screen.dart';
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
            title: 'title_covid',
          ),
          SizedBox(
            height: 20,
          ),
          ItemSelectorRow(
            title: 'active_screening',
            assetImage: 'asset/image/chat.svg',
            onClick: () => gotoWebviewScreen(title: 'active_screening', url: "url_covid_active_screening"),
          ),
          ItemSelectorRow(
            title: 'info_about_covid',
            assetImage: 'asset/image/chat.svg',
            onClick: () => gotoWebviewScreen(title: 'info_about_covid', url: "url_info_about_covid"),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    ));
  }

  void gotoWebviewScreen({String title, String url}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebviewScreen(
            title: title,
            url: url,
          ),
        ));
  }
}
