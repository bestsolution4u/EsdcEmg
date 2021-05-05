import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/screen/main/dashboard/feedback_screen.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:esdc_emg/widget/row/category_label.dart';
import 'package:esdc_emg/widget/row/setting_item_row.dart';
import 'package:esdc_emg/widget/row/setting_switch_row.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  bool shareAnalytics = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChildAppbar(title: "Settings",),
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        CategoryLabel(label: 'INBOX SETTINGS'),
                        SettingItemRow(label: 'filtered_inbox', value: 'by_location', onClick: () {},),
                        SettingItemRow(label: 'notifications', value: 'only_urgent_msg', onClick: () {},),
                        SizedBox(height: 10,),
                        CategoryLabel(label: 'FEEDBACK'),
                        SettingItemRow(label: 'give_us_feedback', onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackScreen(),)),),
                        SettingSwitchRow(label: 'share_app_analytics', value: shareAnalytics, onChange: (val) {
                          setState(() {
                            shareAnalytics = val;
                          });
                        },),
                        CategoryLabel(label: AppLocalization.of(context).trans('app_dev_purpose'), marginTop: 8,),
                        SizedBox(height: 10,),
                        CategoryLabel(label: 'LANGUAGE'),
                        SettingItemRow(label: 'lang', value: AppLocalization.currentLanguage ?? 'en', onClick: () => openLanguageSetting(),),
                        CategoryLabel(label: AppLocalization.of(context).trans('update_phone_settings'), marginTop: 8,),
                      ],
                    ),
                  )
              )
            ],
          ),
        )
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
                  Globals.onLocaleChanged(Locale('en'));
                  Navigator.pop(context);
                },
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(child: Text(AppLocalization.of(context).trans('en'), style: TextStyle(fontSize: 14, color: Styles.textBlack, fontWeight: FontWeight.w400),)),
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
                  Globals.onLocaleChanged(Locale('fr'));
                  Navigator.pop(context);
                },
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(child: Text(AppLocalization.of(context).trans('fr'), style: TextStyle(fontSize: 14, color: Styles.textBlack, fontWeight: FontWeight.w400),)),
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
