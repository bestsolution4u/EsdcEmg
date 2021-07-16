import 'dart:io';

import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/util/screen_util.dart';
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
            child: Semantics(
              label: AppLocalization.of(context).trans(widget.title),
              excludeSemantics: true,
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
                            ? Color(0xFF3378C6)
                            : Styles.darkerBlue,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        height: 0.75
                    ),
                    textAlign: TextAlign.center,
                    textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
                  )
                ],
              ),
            ),
          )),
          SizedBox(height: Platform.isIOS ? 20 : 0,)
        ],
      )
    );
  }
}
