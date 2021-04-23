import 'package:esdc_emg/config/style.dart';
import 'package:flutter/material.dart';

class CategoryLabel extends StatelessWidget {

  final String label;

  CategoryLabel({this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 3),
      width: double.infinity,
      child: Text(label, style: TextStyle(color: Styles.darkGray, fontSize: 14, fontWeight: FontWeight.w400),),
    );
  }
}
