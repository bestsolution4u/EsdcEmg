import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/style.dart';
import '../../localization/app_localization.dart';
import '../button/ripple_component.dart';

class ItemRow extends StatelessWidget {
  final String title, icon;
  final bool isFirst, isLast;
  final VoidCallback onClick;
  final double iconSize;

  ItemRow({this.title, this.icon, this.iconSize = 20, this.onClick, this.isFirst = false, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return RippleComponent(
      onClick: onClick,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(isFirst ? 8 : 0), topRight: Radius.circular(isFirst ? 8 : 0), bottomLeft: Radius.circular(isLast ? 8 : 0), bottomRight: Radius.circular(isLast ? 8 : 0)), color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(width: 8,),
            icon != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: SvgPicture.asset(
                      icon,
                      height: iconSize,
                      width: iconSize,
                    ),
                  )
                : Container(),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      AppLocalization.of(context).trans(title),
                      style: TextStyle(color: Styles.darkBlue, fontSize: 16, fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey,
              size: 24,
            )
          ],
        ),
      ),
    );
  }
}
