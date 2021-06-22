import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroRow extends StatelessWidget {
  final String icon, title, semanticLabel;
  final double iconSize;

  IntroRow({this.icon, this.title, this.iconSize = 36, this.semanticLabel});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: AppLocalization.of(context).trans(semanticLabel),
      excludeSemantics: true,
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
          ))
        ],
      ),
    );
  }
}
