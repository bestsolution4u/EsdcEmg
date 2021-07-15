import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/util/screen_util.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../webview_screen.dart';

class ContactDetailScreen extends StatefulWidget {
  final String title;
  final String phone1, phone2;
  final String phoneDesc1, phoneDesc2;
  final String website;
  final String description;

  ContactDetailScreen({this.title = "", this.phone1 = "", this.phone2 = "", this.phoneDesc1 = "", this.phoneDesc2 = "", this.website = "", this.description});

  @override
  _ContactDetailScreenState createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: "Contact detail screen loaded",
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChildAppbar(
                title: widget.title,
                titleSize: 20,
              ),
              Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Styles.lightGray,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalization.of(context).trans('telephone'),
                                  style: TextStyle(color: Colors.black, fontSize: 12),
                                  textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                widget.phoneDesc1.isEmpty
                                    ? Container()
                                    : Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    AppLocalization.of(context).trans(widget.phoneDesc1),
                                    style: TextStyle(color: Colors.black, fontSize: 14),
                                    textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
                                  ),
                                ),
                                RippleComponent(
                                  onClick: () {
                                    String phone = AppLocalization.of(context).trans(widget.phone1);
                                    if (phone.startsWith("(")) phone = "1-" + phone.replaceAll("(", "").replaceAll(")", "");
                                    launch("tel://" + phone.replaceAll("(", "").replaceAll(")", "").replaceAll("-", ""));
                                  },
                                  child: Text(
                                    AppLocalization.of(context).trans(widget.phone1),
                                    style: TextStyle(color: Styles.blue, fontSize: 16),
                                    textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
                                  ),
                                ),
                                widget.phone2.isEmpty ? Container() : SizedBox(height: 10,),
                                widget.phoneDesc2.isEmpty
                                    ? Container()
                                    : Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    AppLocalization.of(context).trans(widget.phoneDesc2),
                                    style: TextStyle(color: Colors.black, fontSize: 14),
                                    textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
                                  ),
                                ),
                                widget.phone2.isEmpty
                                    ? Container()
                                    : RippleComponent(
                                  onClick: () {
                                    String phone = AppLocalization.of(context).trans(widget.phone2);
                                    if (phone.startsWith("(")) phone = "1-" + phone.replaceAll("(", "").replaceAll(")", "");
                                    launch("tel://" + phone.replaceAll("(", "").replaceAll(")", "").replaceAll("-", ""));
                                  },
                                  child: Text(
                                    AppLocalization.of(context).trans(widget.phone2),
                                    style: TextStyle(color: Styles.blue, fontSize: 16),
                                    textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RippleComponent(
                                  onClick: () {
                                    if (widget.website == 'site_contact_sunlife_health_care_plan') {
                                      launch(AppLocalization.of(context).trans(widget.website));
                                    } else {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => WebviewScreen(title: widget.title, url: widget.website,)));
                                    }
                                  },
                                  child: Text(
                                    AppLocalization.of(context).trans('website'),
                                    style: TextStyle(color: Styles.blue, fontSize: 16),
                                    textScaleFactor: ScreenUtil.calcTextScaleFactor(context),),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          widget.description != null && widget.description.isNotEmpty ? Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalization.of(context).trans('description'),
                                  style: TextStyle(color: Styles.blue, fontSize: 12),
                                  textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  AppLocalization.of(context).trans(widget.description),
                                  style: TextStyle(fontSize: 12, color: Colors.black),
                                  textScaleFactor: ScreenUtil.calcTextScaleFactor(context),)
                              ],
                            ),
                          ) : Container(),
                          SizedBox(height: 20,)
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
