import 'package:esdc_emg/config/global.dart';
import 'package:flutter/material.dart';

import '../../config/style.dart';
import '../../localization/app_localization.dart';
import '../button/ripple_component.dart';

class ContactItemRow extends StatelessWidget {

  final String title;
  final VoidCallback onClick;

  ContactItemRow({this.title, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: AppLocalization.of(context).trans(title),
      button: true,
      excludeSemantics: true,
      child: RippleComponent(
        onClick: onClick,
        child: Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Text(
              AppLocalization.of(context).trans(title), style: TextStyle(color: Styles.darkBlue, fontSize: 16, fontWeight: FontWeight.w600),
            textScaleFactor: Globals.MAX_TEXT_SCALE_FACTOR,),
        ),
      ),
    );
  }
}
