import 'package:esdc_emg/localization/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onClick;
  final double rippleRadius, padding;
  final String sematicLabel;

  AppIconButton({this.icon, this.sematicLabel = '', this.onClick, this.rippleRadius = 16, this.padding = 8});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: sematicLabel,
      value: sematicLabel,
      button: true,
      excludeSemantics: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onClick,
          highlightColor: Colors.grey[500].withOpacity(0.3),
          splashColor: Colors.grey[800].withOpacity(0.3),
          borderRadius: BorderRadius.circular(this.rippleRadius),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: icon,
          ),
        ),
      ),
    );
  }
}
