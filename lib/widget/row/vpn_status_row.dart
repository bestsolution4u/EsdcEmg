import 'package:esdc_emg/config/style.dart';
import 'package:flutter/material.dart';

class VpnStatusRow extends StatelessWidget {
  final String title;
  final int percent;
  final Color color;

  VpnStatusRow({this.title, this.percent, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          child: Text(
            title,
            style: TextStyle(color: Styles.textBlack, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 50,
          child: Text(
            '$percent%',
            style: TextStyle(color: Styles.textBlack, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: percent,
            child: Container(width: double.infinity, height: 32, color: color,)
        ),
        Expanded(
            flex: 100 - percent,
            child: Container(width: double.infinity, height: 32, color: Colors.white,)
        ),
      ],
    );
  }
}
