import 'package:esdc_emg/config/style.dart';
import 'package:flutter/material.dart';

class ESDCAppbar {
  static AppBar generateMainAppbar({String title = "", Widget action}) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      title: Text(title, style: TextStyle(color: Styles.textBlack, fontSize: 28, fontWeight: FontWeight.w800)),
      actions: [
        action != null ? action : Container()
      ],
    );
  }
}