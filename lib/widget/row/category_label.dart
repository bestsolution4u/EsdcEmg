import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:flutter/material.dart';

class CategoryLabel extends StatelessWidget {

  final String label;
  final double marginTop;

  CategoryLabel({this.label, this.marginTop = 24});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: marginTop, left: 12, right: 12, bottom: 3),
      width: double.infinity,
      child: Text(AppLocalization.of(context).trans(label), style: TextStyle(color: Styles.darkGray, fontSize: 14, fontWeight: FontWeight.w400),),
    );
  }
}
