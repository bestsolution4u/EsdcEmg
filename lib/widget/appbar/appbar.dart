import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:flutter/material.dart';

class ESDCAppbar {
  static AppBar generateMainAppbar({String title = "", Widget action, BuildContext context}) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      title: Text(AppLocalization.of(context).trans(title), style: TextStyle(color: Styles.textBlack, fontSize: 24, fontWeight: FontWeight.w800)),
      actions: [
        action != null ? action : Container()
      ],
    );
  }
}