import 'package:esdc_emg/bloc/bloc.dart';
import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/screen/main/dashboard/feedback_screen.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:esdc_emg/widget/row/category_label.dart';
import 'package:esdc_emg/widget/row/setting_item_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io' show Platform;

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  bool shareAnalytics = false;

  SettingBloc _settingBloc;

  @override
  void initState() {
    super.initState();
    _settingBloc = BlocProvider.of<SettingBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChildAppbar(title: "title_settings",),
            Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Styles.lightGray,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CategoryLabel(label: 'message_setting'),
                        /*SettingItemRow(label: 'filtered_inbox', value: 'by_location', onClick: () {},),*/
                        SettingItemRow(label: 'notifications', value: 'all_messages', onClick: () {},),
                        CategoryLabel(label: 'feed_back'),
                        SettingItemRow(label: 'give_us_feedback', onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackScreen(),)),),
                        /*SettingSwitchRow(label: 'share_app_analytics', value: shareAnalytics, onChange: (val) {
                          setState(() {
                            shareAnalytics = val;
                          });
                        },),*/
                        CategoryLabel(label: 'lang'),
                        SettingItemRow(label: 'lang', value: AppLocalization.currentLanguage ?? 'en', onClick: () => openLanguageSetting(),),
                        Platform.isIOS ? CategoryLabel(label: 'update_phone_settings', fontSize: 12, color: Colors.grey, marginTop: 8, fontWeight: FontWeight.w400,) : Container(),
                      ],
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  void openLanguageSetting() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) => Wrap(children: [
        Container(
          height: 250,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text(
                AppLocalization.of(context).trans("select_language"),
                style: TextStyle(
                    color: Styles.textBlack,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              RippleComponent(
                onClick: () async {
                  _settingBloc.add(SettingUpdateLanguageEvent(language: Globals.SupportedLanguageCodes[0]));
                  Navigator.pop(context);
                },
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(child: Text(AppLocalization.of(context).trans(Globals.SupportedLanguageCodes[0]), style: TextStyle(fontSize: 14, color: Styles.textBlack, fontWeight: FontWeight.w400),)),
                          Icon(Icons.keyboard_arrow_right, size: 28, color: Colors.grey),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Divider(height: 1),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              RippleComponent(
                onClick: () async {
                  _settingBloc.add(SettingUpdateLanguageEvent(language: Globals.SupportedLanguageCodes[1]));
                  Navigator.pop(context);
                },
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(child: Text(AppLocalization.of(context).trans(Globals.SupportedLanguageCodes[1]), style: TextStyle(fontSize: 14, color: Styles.textBlack, fontWeight: FontWeight.w400),)),
                          Icon(Icons.keyboard_arrow_right, size: 28, color: Colors.grey),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Divider(height: 1),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],),);
  }
}
