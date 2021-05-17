import 'package:flutter/material.dart';

import '../../config/style.dart';

class ItemDivider extends StatelessWidget {

  final double paddingLeft;

  ItemDivider({this.paddingLeft = 42});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.only(left: paddingLeft),
      child: Divider(height: 1, color: Styles.bgGrey,),
    );
  }
}
