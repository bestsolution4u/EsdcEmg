import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroRow extends StatelessWidget {

  final String icon, title;
  final double iconSize;

  IntroRow({this.icon, this.title, this.iconSize = 40});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          allowDrawingOutsideViewBox: true,
          width: iconSize,
        ),
        SizedBox(width: 20,),
        Flexible(child: Text(AppLocalization.of(context).trans(title), style: TextStyle(color: Styles.darkerBlue, fontSize: 16), maxLines: 2, overflow: TextOverflow.ellipsis,))
      ],
    );
  }
}
