import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorderedButton extends StatelessWidget {

  final String title;
  final Color color, buttonColor, borderColor;
  final VoidCallback onClick;

  BorderedButton({this.title, this.color = Styles.darkerBlue, this.borderColor = Styles.darkerBlue, this.buttonColor = Colors.transparent, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: FlatButton(
        minWidth: MediaQuery.of(context).size.width,
        color: buttonColor,
        onPressed: onClick,
        child: Text(title, style: TextStyle(color: color), textScaleFactor: Globals.MAX_TEXT_SCALE_FACTOR,),
        textColor: color,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: borderColor,
                width: 1,
                style: BorderStyle.solid),
            borderRadius:
            BorderRadius.circular(5)),
      ),
    );
  }
}
