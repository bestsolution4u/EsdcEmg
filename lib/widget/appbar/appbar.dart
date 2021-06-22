import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ESDCAppbar {
  static AppBar renderMainAppbar({String icon, String title, Widget action, BuildContext context}) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      title: Row(
        children: [
          Semantics(
            label: AppLocalization.of(context).trans(title),
            excludeSemantics: true,
            child: SvgPicture.asset(
              icon,
              allowDrawingOutsideViewBox: true,
              height: 30,
            ),
          ),
          SizedBox(width: 10,),
          Semantics(
            label: AppLocalization.of(context).trans(title),
            excludeSemantics: true,
            child: Text(AppLocalization.of(context).trans(title), style: TextStyle(color: Styles.darkBlue, fontSize: 22, fontWeight: FontWeight.w700)),
          )
        ],
      ),
      actions: [
        action != null ? action : Container()
      ],
    );
  }
}