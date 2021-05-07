import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/widget/button/icon_button.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:flutter/material.dart';

class ChildAppbar extends StatelessWidget {
  final String title;
  final Widget action;
  final bool isMessage;

  ChildAppbar({this.title, this.action, this.isMessage = false});

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
                  color: Styles.darkGray,
                ),
                rippleRadius: 36,
                padding: 4,
                onClick: () => Navigator.pop(context),
              ),
              RippleComponent(
                child: Text(
                  AppLocalization.of(context).trans('navigation_back'),
                  style: TextStyle(color: Styles.darkGray, fontSize: 20, fontWeight: FontWeight.w500),
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
            style: TextStyle(color: Styles.textBlack, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Divider(
          height: 1,
          color: Styles.darkGray,
        )
      ],
    );
  }
}
