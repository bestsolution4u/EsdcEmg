import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/screen/main/webview_screen.dart';
import 'package:esdc_emg/widget/appbar/child_image_appbar.dart';
import 'package:esdc_emg/widget/button/border_item_selector.dart';
import 'package:flutter/material.dart';

class CovidScreen extends StatefulWidget {
  @override
  _CovidScreenState createState() => _CovidScreenState();
}

class _CovidScreenState extends State<CovidScreen> {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: "Covid screen loaded",
      value: "Covid screen loaded",
      child: Scaffold(
        backgroundColor: Styles.darkerBlue,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChildImageAppbar(
                  title: "title_covid",
                  icon: 'asset/image/icon-nav-covid.svg',
                ),
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BorderItemSelector(
                    title: 'active_screening_2',
                    icon: 'asset/image/icon-covid.svg',
                    sortKey: 1,
                    iconSize: 60,
                    onClick: () => gotoWebviewScreen(
                        title: "active_screening",
                        url: 'url_covid_active_screening'),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BorderItemSelector(
                    title: 'info_about_covid_2',
                    icon: 'asset/image/icon-tile-active-screening.svg',
                    sortKey: 2,
                    onClick: () => gotoWebviewScreen(
                        title: "info_about_covid",
                        url: 'url_info_about_covid'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
