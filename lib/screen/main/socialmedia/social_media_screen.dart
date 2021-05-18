import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/row/category_label.dart';
import 'package:esdc_emg/widget/row/item_divider.dart';
import 'package:esdc_emg/widget/row/item_row.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:flutter/material.dart';

import '../webview_screen.dart';

class SocialMediaScreen extends StatefulWidget {
  @override
  _SocialMediaScreenState createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.lightGray,
      appBar: ESDCAppbar.renderMainAppbar(
          title: 'title_soci_medi',
          icon: 'asset/image/tab-social-active.svg',
          context: context
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CategoryLabel(label: 'facebook', icon: 'asset/image/icon-facebook.svg'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  ItemRow(title: 'esdc', isFirst: true, onClick: () => gotoWebviewScreen(title: 'esdc_facebook', url: 'url_esdc_facebook')),
                  ItemDivider(paddingLeft: 15),
                  ItemRow(title: 'access_canada', onClick: () => gotoWebviewScreen(title: 'access_canada', url: 'url_access_canada')),
                  ItemDivider(paddingLeft: 15),
                  ItemRow(title: 'leader_today', onClick: () => gotoWebviewScreen(title: 'leader_today', url: 'url_leader_today')),
                  ItemDivider(paddingLeft: 15),
                  ItemRow(title: 'senior_canada', isLast: true, onClick: () => gotoWebviewScreen(title: 'senior_canada', url: 'url_senior_canada')),
                ],
              ),
            ),
            CategoryLabel(label: 'twitter', icon: 'asset/image/icon-twitter.svg'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  ItemRow(title: 'esdc', isFirst: true, onClick: () => gotoWebviewScreen(title: 'esdc_twitter', url: 'url_esdc_twitter')),
                  ItemDivider(paddingLeft: 15),
                  ItemRow(title: 'service_canada', onClick: () => gotoWebviewScreen(title: 'service_canada', url: 'url_service_canada')),
                  ItemDivider(paddingLeft: 15),
                  ItemRow(title: 'access_canada', isLast: true, onClick: () => gotoWebviewScreen(title: 'access_canada', url: 'url_access_canada_twitter')),
                ],
              ),
            ),
            CategoryLabel(label: 'you_tube', icon: 'asset/image/icon-youtube.svg'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  ItemRow(title: 'esdc', isFirst: true, onClick: () => gotoWebviewScreen(title: 'esdc_youtube', url: 'url_esdc_youtube')),
                  ItemDivider(paddingLeft: 15),
                  ItemRow(title: 'service_canada', isLast: true, onClick: () => gotoWebviewScreen(title: 'service_canada', url: 'url_service_canada_youtube')),
                ],
              ),
            ),
            CategoryLabel(label: 'instagram', icon: 'asset/image/icon-instagram.svg'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  ItemRow(title: 'esdc', isFirst: true, isLast: true, onClick: () => gotoWebviewScreen(title: 'esdc_instagram', url: 'url_esdc_instagram')),
                ],
              ),
            ),
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
