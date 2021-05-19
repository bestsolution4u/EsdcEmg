import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/widget/button/icon_button.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:flutter/material.dart';

class ChildAppbar extends StatelessWidget {
  final String title;
  final Widget action;
  final bool isMessage, showDivider;

  ChildAppbar({this.title, this.action, this.isMessage = false, this.showDivider = true});

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
                  size: 28,
                  color: Styles.darkerBlue,
                ),
                rippleRadius: 36,
                padding: 4,
                onClick: () => Navigator.pop(context),
              ),
              RippleComponent(
                child: Text(
                  AppLocalization.of(context).trans('navigation_back'),
                  style: TextStyle(color: Styles.darkerBlue, fontSize: 18, fontWeight: FontWeight.w500),
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
          child: Text(
            isMessage ? title : AppLocalization.of(context).trans(title),
            style: TextStyle(color: Styles.darkerBlue, fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10,),
        showDivider ? Divider(
          height: 1,
          color: Styles.lightGray,
        ) : Container()
      ],
    );
  }
}
