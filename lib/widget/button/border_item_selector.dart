import 'package:esdc_emg/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BorderItemSelector extends StatelessWidget {

  final String title, icon, description;
  final double iconSize, fontSize;
  final Color color;
  final VoidCallback onClick;

  BorderItemSelector({this.title, this.icon, this.description = "", this.iconSize = 50, this.color = Colors.white, this.fontSize = 16, this.onClick});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      minWidth: MediaQuery.of(context).size.width,
      height: 160,
      onPressed: onClick,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            allowDrawingOutsideViewBox: true,
            height: iconSize,
          ),
          SizedBox(height: 10,),
          Flexible(child: Text(AppLocalization.of(context).trans(title), style: TextStyle(color: color, fontSize: fontSize), textAlign: TextAlign.center)),
          description.isNotEmpty ? SizedBox(height: 5,) : Container(),
          description.isNotEmpty ? Flexible(child: Text(AppLocalization.of(context).trans(description), style: TextStyle(color: color, fontSize: 12), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,)) : Container()
        ],
      ),
      textColor: color,
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: color,
              width: 1,
              style: BorderStyle.solid),
          borderRadius:
          BorderRadius.circular(15)),
    );
  }
}
