import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/util/screen_util.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:flutter/material.dart';

class DashboardButton extends StatelessWidget {

  final VoidCallback onClick;
  final Widget icon;
  final String title;

  DashboardButton({this.onClick, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: RippleComponent(
        onClick: onClick,
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: new BorderSide(
                  color: Styles.darkGray, width: 1.0)),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                icon,
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  maxLines: 2,
                  style: TextStyle(
                      color: Styles.textBlack,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                  textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
