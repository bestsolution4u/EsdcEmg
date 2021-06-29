import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/screen/main/webview_screen.dart';
import 'package:esdc_emg/widget/appbar/child_image_appbar.dart';
import 'package:esdc_emg/widget/button/border_item_selector.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WellnessScreen extends StatefulWidget {
  @override
  _WellnessScreenState createState() => _WellnessScreenState();
}

class _WellnessScreenState extends State<WellnessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChildImageAppbar(
                title: "wellness",
                icon: 'asset/image/icon-wellness.svg',
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BorderItemSelector(
                  title: 'employ_assistance_program_2',
                  icon: 'asset/image/icon-nav-eap.svg',
                  onClick: () => gotoWebviewScreen(
                      title: "employ_assistance_program",
                      url: 'url_employ_assistance_program'),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BorderItemSelector(
                  title: 'life_speak',
                  icon: 'asset/image/icon-nav-lifespeak.svg',
                  description: 'life_speak_desc',
                  onClick: () {
                    launch(AppLocalization.of(context).trans('url_life_speak'));
                    /*gotoWebviewScreen(
                      title: "life_speak",
                      url: 'url_life_speak');*/
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void gotoWebviewScreen({String title, String url}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WebviewScreen(title: title, url: url,),));
  }
}
