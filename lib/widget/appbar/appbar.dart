import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ESDCAppbar {
  static AppBar renderMainAppbar({String icon, String title, Widget action, BuildContext context}) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      title: Semantics(
        label: AppLocalization.of(context).trans(title),
        excludeSemantics: true,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              allowDrawingOutsideViewBox: true,
              height: 30,
            ),
            SizedBox(width: 10,),
            Text(
              AppLocalization.of(context).trans(title),
              style: TextStyle(color: Styles.darkBlue, fontSize: 22, fontWeight: FontWeight.w700),
              textScaleFactor: ScreenUtil.calcTextScaleFactor(context),),
          ],
        ),
      ),
      actions: [
        action != null ? action : Container()
      ],
    );
  }
}