import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/util/screen_util.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryButton extends StatelessWidget {
  final Color backgroundColor;
  final String icon, title;
  final double iconSize, fontSize;
  final VoidCallback onClick;
  final double sortKey;

  CategoryButton({this.backgroundColor = Styles.darkBlue, this.icon, this.title, this.iconSize = 70, this.fontSize = 13, this.onClick, this.sortKey});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Semantics(
          label: AppLocalization.of(context).trans(title),
          value: AppLocalization.of(context).trans(title),
          button: true,
          excludeSemantics: true,
          sortKey: OrdinalSortKey(sortKey),
          child: RippleComponent(
            onClick: onClick,
            child: Container(
              width: double.infinity,
              height: ScreenUtil.calcTextScaleFactor(context) > 1 ? 185 : 165,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    offset: Offset(1, 1),
                    spreadRadius: 2,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      icon,
                      allowDrawingOutsideViewBox: true,
                      height: iconSize,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      AppLocalization.of(context).trans(title),
                      style: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.w500, height: 1.3),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
