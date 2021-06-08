import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/model/message_model.dart';
import 'package:esdc_emg/widget/button/icon_button.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class MessageAppBar extends StatelessWidget {
  final MessageModel message;
  final Widget action;

  MessageAppBar({this.message, this.action});

  @override
  Widget build(BuildContext context) {
    String category = "";
    for (int i = 0; i < Globals.MESSAGE_CATEGORIES.length; i++) {
      if (message.category.toLowerCase().contains(Globals.MESSAGE_CATEGORIES[i])) {
        category = Globals.MESSAGE_CATEGORIES[i];
      }
    }

    String audience = "";
    final split = message.audience.split(',');
    for (int i = 0; i < split.length; i++) {
      String val = split[i];
      if (val == null || val.isEmpty) continue;
      if (!audience.isEmpty) audience += ", ";
      audience += AppLocalization.of(context).trans(val);
    }
    String categoryLine = "";
    if (category.isNotEmpty) {
      categoryLine = AppLocalization.of(context).trans(category) + ", ";
    }
    if (audience.isNotEmpty) {
      categoryLine += audience;
    }
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
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              message.urgentInd == 'Urgent' ? Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Styles.red,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text(AppLocalization.of(context).trans('urgent'), style: TextStyle(color: Colors.white, fontSize: 14),),
                ),
              ) : Container(),
              Text(
                DateFormat(AppLocalization.currentLanguage == 'fr' ? 'dd MMMM yyyy' : 'MMMM dd, yyyy', AppLocalization.currentLanguage).format(DateTime.parse(message.effectiveDate)),
                style: TextStyle(color: Styles.textBlack, fontSize: 14),
                textAlign: TextAlign.start,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Text(
            categoryLine,
            style: TextStyle(color: Styles.textBlack, fontSize: 16),
            textAlign: TextAlign.start,
          )
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 15, bottom: 4),
          child: Text(
            AppLocalization.currentLanguage == 'fr' ? message.titleFr : message.title,
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

