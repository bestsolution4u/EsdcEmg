import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryLabel extends StatelessWidget {

  final String label, icon;
  final double marginTop;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  CategoryLabel({this.label, this.icon, this.color = Styles.darkerBlue, this.fontWeight = FontWeight.bold, this.fontSize = 20, this.marginTop = 24});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: marginTop, left: 15, right: 12),
      width: double.infinity,
      child: Semantics(
        label: AppLocalization.of(context).trans(label),
        excludeSemantics: true,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null ? Padding(padding: const EdgeInsets.only(right: 10), child: SvgPicture.asset(
              icon,
              height: 20,
              width: 20,
            ),) : Container(),
            Flexible(child: Text(
              AppLocalization.of(context).trans(label),
              style: TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
              textScaleFactor: Globals.MAX_TEXT_SCALE_FACTOR,))
          ],
        ),
      ),
    );
  }
}
