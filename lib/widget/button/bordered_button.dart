import 'package:esdc_emg/config/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorderedButton extends StatelessWidget {

  final String title;
  final Color color;
  final VoidCallback onClick;

  BorderedButton({this.title, this.color = Styles.textBlack, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: FlatButton(
        minWidth: MediaQuery.of(context).size.width,
        onPressed: onClick,
        child: Text(title, style: TextStyle(color: color),),
        textColor: color,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: color,
                width: 1,
                style: BorderStyle.solid),
            borderRadius:
            BorderRadius.circular(5)),
      ),
    );
  }
}
