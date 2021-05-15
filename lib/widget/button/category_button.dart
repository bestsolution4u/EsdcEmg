import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryButton extends StatelessWidget {

  final Color backgroundColor;
  final String icon, title;
  final double iconSize;
  final VoidCallback onClick;

  CategoryButton({this.backgroundColor = Styles.darkBlue, this.icon, this.title, this.iconSize = 70, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RippleComponent(
          onClick: onClick,
          child: Container(
            width: double.infinity,
            height: 165,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: backgroundColor
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
                  SizedBox(height: 10,),
                  Text(
                    AppLocalization.of(context).trans(title),
                    style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500, height: 1.3),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
