import 'dart:io';

import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainTabItem extends StatefulWidget {

  final String title, image, imageInactive;
  final bool selected;
  final Widget badge;

  MainTabItem({this.title = "", this.image = "", this.imageInactive = "", this.selected = false, this.badge});

  @override
  _MainTabItemState createState() => _MainTabItemState();
}

class _MainTabItemState extends State<MainTabItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Platform.isIOS ? 80 : 60,
      child: Column(
        children: [
          Expanded(child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    SvgPicture.asset(
                      widget.selected ? widget.image : widget.imageInactive,
                      allowDrawingOutsideViewBox: true,
                      width: 25,
                      height: 25,
                    ),
                    widget.badge?? SizedBox(width: 0, height: 0,)
                  ],
                ),
                SizedBox(height: 2,),
                Text(
                  AppLocalization.of(context).trans(widget.title),
                  style: TextStyle(
                      color: widget.selected
                          ? Styles.blue
                          : Styles.darkerBlue,
                      fontSize: 10
                  ),
                )
              ],
            ),
          )),
          SizedBox(height: Platform.isIOS ? 20 : 0,)
        ],
      )
    );
  }
}
