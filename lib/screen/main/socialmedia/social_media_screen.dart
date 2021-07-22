import 'dart:io';

import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/row/category_label.dart';
import 'package:esdc_emg/widget/row/item_divider.dart';
import 'package:esdc_emg/widget/row/item_row.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../webview_screen.dart';

class SocialMediaScreen extends StatefulWidget {
  @override
  _SocialMediaScreenState createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      explicitChildNodes: true,
      focusable: true,
      focused: true,
      label: AppLocalization.of(context).trans("social_page_loaded"),
      child: Scaffold(
        backgroundColor: Styles.lightGray,
        appBar: ESDCAppbar.renderMainAppbar(
            title: 'title_soci_medi',
            icon: 'asset/image/tab-social-active.svg',
            context: context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CategoryLabel(
                  label: 'facebook', icon: 'asset/image/icon-facebook.svg'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    ItemRow(
                        title: 'esdc',
                        isFirst: true,
                        sortKey: 1,
                        onClick: () => openFacebookLink(
                            title: 'esdc_facebook',
                            linkName: 'url_esdc_facebook')),
                    ItemDivider(paddingLeft: 15),
                    ItemRow(
                        title: 'access_canada',
                        sortKey: 2,
                        onClick: () => openFacebookLink(
                            title: 'access_canada',
                            linkName: 'url_access_canada')),
                    ItemDivider(paddingLeft: 15),
                    ItemRow(
                        title: 'leader_today',
                        sortKey: 3,
                        onClick: () => openFacebookLink(
                            title: 'leader_today', linkName: 'url_leader_today')),
                    ItemDivider(paddingLeft: 15),
                    ItemRow(
                        title: 'senior_canada',
                        isLast: true,
                        sortKey: 4,
                        onClick: () => openFacebookLink(
                            title: 'senior_canada',
                            linkName: 'url_senior_canada')),
                  ],
                ),
              ),
              CategoryLabel(
                  label: 'twitter', icon: 'asset/image/icon-twitter.svg'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    ItemRow(
                        title: 'esdc',
                        isFirst: true,
                        sortKey: 5,
                        onClick: () => openTwitterLink(
                            title: 'esdc_twitter', url: 'url_esdc_twitter')),
                    ItemDivider(paddingLeft: 15),
                    ItemRow(
                        title: 'service_canada',
                        sortKey: 6,
                        onClick: () => openTwitterLink(
                            title: 'service_canada', url: 'url_service_canada')),
                    ItemDivider(paddingLeft: 15),
                    ItemRow(
                        title: 'access_canada',
                        isLast: true,
                        sortKey: 7,
                        onClick: () => openTwitterLink(
                            title: 'access_canada',
                            url: 'url_access_canada_twitter')),
                  ],
                ),
              ),
              CategoryLabel(
                  label: 'you_tube', icon: 'asset/image/icon-youtube.svg'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    ItemRow(
                        title: 'esdc',
                        isFirst: true,
                        sortKey: 8,
                        onClick: () => openYoutubeLink(
                            title: 'esdc_youtube', url: 'url_esdc_youtube')),
                    ItemDivider(paddingLeft: 15),
                    ItemRow(
                        title: 'service_canada',
                        isLast: true,
                        sortKey: 9,
                        onClick: () => openYoutubeLink(
                            title: 'service_canada',
                            url: 'url_service_canada_youtube')),
                  ],
                ),
              ),
              CategoryLabel(
                  label: 'instagram', icon: 'asset/image/icon-instagram.svg'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    ItemRow(
                        title: 'esdc',
                        isFirst: true,
                        isLast: true,
                        sortKey: 10,
                        onClick: () => openInstagramLink(
                            title: 'esdc_instagram', url: 'url_esdc_instagram')),
                  ],
                ),
              ),
              CategoryLabel(
                  label: 'linkedin', icon: 'asset/image/icon-linkedin.svg'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    ItemRow(
                        title: 'esdc',
                        isFirst: true,
                        sortKey: 11,
                        onClick: () => openLinkedinLink(
                            title: 'esdc_linkedin', url: 'url_esdc_linkedin')),
                    ItemDivider(paddingLeft: 15),
                    ItemRow(
                        title: 'service_canada',
                        isLast: true,
                        sortKey: 12,
                        onClick: () => openLinkedinLink(
                            title: 'service_canada',
                            url: 'url_service_canada_linkedin')),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openFacebookLink({String title, String linkName}) async {
    String facebookProtocolUrl = "";
    if (Platform.isIOS) {
      facebookProtocolUrl = 'fb://profile/' +
          AppLocalization.of(context).trans('facebook_page_id_' + linkName);
    } else {
      facebookProtocolUrl = 'fb://page/' +
          AppLocalization.of(context).trans('facebook_page_id_' + linkName);
    }
    try {
      bool launched = await launch(facebookProtocolUrl,
          forceSafariVC: false, forceWebView: false);
      if (!launched) gotoWebviewScreen(title: title, url: linkName);
    } catch (e) {
      gotoWebviewScreen(title: title, url: linkName);
    }
  }

  Future<void> openTwitterLink({String title, String url}) async {
    if (await canLaunch(AppLocalization.of(context).trans(url))) {
      await launch(AppLocalization.of(context).trans(url));
    } else {
      gotoWebviewScreen(title: title, url: url);
    }
  }

  Future<void> openYoutubeLink({String title, String url}) async {
    if (await canLaunch(AppLocalization.of(context).trans(url))) {
      await launch(AppLocalization.of(context).trans(url));
    } else {
      gotoWebviewScreen(title: title, url: url);
    }
  }

  Future<void> openInstagramLink({String title, String url}) async {
    if (await canLaunch(AppLocalization.of(context).trans(url))) {
      await launch(AppLocalization.of(context).trans(url));
    } else {
      gotoWebviewScreen(title: title, url: url);
    }
  }

  Future<void> openLinkedinLink({String title, String url}) async {
    if (await canLaunch(AppLocalization.of(context).trans(url))) {
      await launch(AppLocalization.of(context).trans(url));
    } else {
      gotoWebviewScreen(title: title, url: url);
    }
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
