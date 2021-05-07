import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainTabItem extends StatefulWidget {

  final String title, image;
  final bool selected;
  final Widget badge;

  MainTabItem({this.title = "", this.image = "", this.selected = false, this.badge});

  @override
  _MainTabItemState createState() => _MainTabItemState();
}

class _MainTabItemState extends State<MainTabItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Tab(
        icon: Stack(
          children: [
            SvgPicture.asset(
              widget.image,
              color: widget.selected
                  ? Styles.purple
                  : Styles.textBlack,
              allowDrawingOutsideViewBox: true,
              height: 20,
            ),
            widget.badge?? SizedBox(width: 0, height: 0,)
          ],
        ),
        child: Text(
          AppLocalization.of(context).trans(widget.title),
          style: TextStyle(
            color: widget.selected
                ? Styles.purple
                : Styles.textBlack,
            fontSize: 12
          ),
        ),
      ),
    );
  }
}
