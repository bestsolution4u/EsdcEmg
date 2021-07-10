import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../config/style.dart';
import '../../localization/app_localization.dart';
import '../button/ripple_component.dart';

class ContactItemRow extends StatelessWidget {

  final String title;
  final VoidCallback onClick;
  final double sortKey;

  ContactItemRow({this.title, this.onClick, this.sortKey});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: AppLocalization.of(context).trans(title),
      value: AppLocalization.of(context).trans(title),
      button: true,
      sortKey: OrdinalSortKey(sortKey),
      excludeSemantics: true,
      child: RippleComponent(
        onClick: onClick,
        child: Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Text(
              AppLocalization.of(context).trans(title),
            style: TextStyle(color: Styles.darkBlue, fontSize: 16, fontWeight: FontWeight.w600),
            textScaleFactor: ScreenUtil.calcTextScaleFactor(context),),
        ),
      ),
    );
  }
}
