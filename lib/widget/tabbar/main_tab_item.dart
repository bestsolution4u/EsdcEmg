import 'package:esdc_emg/config/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainTabItem extends StatefulWidget {

  final String title, image;
  final bool selected;

  MainTabItem({this.title = "", this.image = "", this.selected = false});

  @override
  _MainTabItemState createState() => _MainTabItemState();
}

class _MainTabItemState extends State<MainTabItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Tab(
        icon: SvgPicture.asset(
          widget.image,
          color: widget.selected
              ? Styles.purple
              : Styles.textBlack,
          allowDrawingOutsideViewBox: true,
          height: 20,
        ),
        child: Text(
          widget.title,
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
