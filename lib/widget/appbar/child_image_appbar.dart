import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/widget/button/icon_button.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChildImageAppbar extends StatelessWidget {
  final String title, icon;
  final Widget action;
  final bool isMessage;

  ChildImageAppbar({this.title, this.icon, this.action, this.isMessage = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              AppIconButton(
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  size: 36,
                  color: Colors.white,
                ),
                rippleRadius: 36,
                padding: 4,
                onClick: () => Navigator.pop(context),
              ),
              RippleComponent(
                child: Text(
                  AppLocalization.of(context).trans('navigation_back'),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onClick: () => Navigator.pop(context),
              ),
              Spacer(),
              action != null ? action : Container()
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 15, bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SvgPicture.asset(
                icon,
                allowDrawingOutsideViewBox: true,
                height: 40,
              ),
              SizedBox(width: 16,),
             Flexible(child:  Text(
               isMessage ? title : AppLocalization.of(context).trans(title),
               style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, height: 1),
               maxLines: 2,
               overflow: TextOverflow.ellipsis,
             ))
            ],
          ),
        )
      ],
    );
  }
}
