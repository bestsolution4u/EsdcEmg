import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onClick;
  final double rippleRadius, padding;

  AppIconButton({this.icon, this.onClick, this.rippleRadius = 16, this.padding = 8});

  @override
  Widget build(BuildContext context) {
    return Material(
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
    );
  }
}
