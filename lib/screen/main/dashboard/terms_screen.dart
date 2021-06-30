import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/widget/appbar/child_image_appbar.dart';
import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.darkBlue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChildImageAppbar(
              title: "terms_conditions",
              icon: 'asset/image/icon-feedback.svg',
              iconSize: 30,
              fontSize: 22,
            ),
            SizedBox(height: 10),
            Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                              AppLocalization.of(context).trans('terms_content'),
                            textScaleFactor: Globals.MAX_TEXT_SCALE_FACTOR,),
                        ),
                        SizedBox(height: 30,),
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
}
