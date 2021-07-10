import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroRow extends StatelessWidget {
  final String icon, title, semanticLabel;
  final double iconSize;
  final double sortKey;

  IntroRow({this.icon, this.title, this.iconSize = 36, this.semanticLabel, this.sortKey});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: AppLocalization.of(context).trans(semanticLabel),
      value: AppLocalization.of(context).trans(semanticLabel),
      excludeSemantics: true,
      sortKey: OrdinalSortKey(sortKey),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: SvgPicture.asset(
              icon,
              allowDrawingOutsideViewBox: true,
              width: iconSize,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Flexible(
              child: Text(
            AppLocalization.of(context).trans(title),
            style: TextStyle(color: Styles.darkerBlue, fontSize: 14),
                textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
          ))
        ],
      ),
    );
  }
}
