import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/util/screen_util.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingItemRow extends StatefulWidget {

  final String label, value;
  final VoidCallback onClick;
  final Color backgroundColor;
  final double borderPadding;
  final double paddingHorizontal;
  final bool isValueTranslated, isTopic, isLocation, isSorting;

  SettingItemRow({this.label, this.value, this.isTopic = false, this.isLocation = false, this.isSorting = false, this.onClick, this.backgroundColor = Colors.white, this.borderPadding = 12, this.paddingHorizontal = 20, this.isValueTranslated = true});

  @override
  _SettingItemRowState createState() => _SettingItemRowState();
}

class _SettingItemRowState extends State<SettingItemRow> {
  @override
  Widget build(BuildContext context) {
    String value = "";
    if (widget.isTopic) {
      List<String> topics = widget.value.split(",");
      topics.removeWhere((element) => element.isEmpty);
      if (topics.isEmpty) {
        value = widget.isValueTranslated ? AppLocalization.of(context).trans("none") : "none";
      } else if (topics.length == 1) {
        value = widget.isValueTranslated ? AppLocalization.of(context).trans(topics[0]) : topics[0];
      } else {
        value = topics.length.toString() + " " + (widget.isValueTranslated ? AppLocalization.of(context).trans("categories_selected") : "categories_selected");
      }
    } else if (widget.isLocation) {
      List<String> locations = widget.value.split(",");
      locations.removeWhere((element) => element.isEmpty);
      if (locations.isEmpty) {
        value = widget.isValueTranslated ? AppLocalization.of(context).trans("none") : "none";
      } else if (locations.length == 1) {
        value = widget.isValueTranslated ? AppLocalization.of(context).trans(locations[0]) : locations[0];
      } else {
        value = locations.length.toString() + " " + (widget.isValueTranslated ? AppLocalization.of(context).trans("locations_selected") : "locations_selected");
      }
    } else {
      value = widget.isValueTranslated ? AppLocalization.of(context).trans(widget.value) : widget.value;
    }
    double textScaleFactor = ScreenUtil.calcTextScaleFactor(context);
    return RippleComponent(
      child: Container(
        color: widget.backgroundColor,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: widget.paddingHorizontal, vertical: 10),
              child: textScaleFactor > 1
                  ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalization.of(context).trans(widget.label),
                    style: TextStyle(color: Styles.darkerBlue, fontSize: 14, fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textScaleFactor: ScreenUtil.calcTextScaleFactor(context),),
                  Row(
                    children: [
                      Spacer(),
                      widget.value == null ? Container() : Text(
                        value,
                        style: TextStyle(color: Styles.blue, fontSize: 14, fontWeight: FontWeight.w500),
                        textScaleFactor: ScreenUtil.calcTextScaleFactor(context),),
                      SizedBox(width: 5,),
                      Icon(Icons.keyboard_arrow_right, size: 28, color: Colors.grey)
                    ],
                  )
                ],
              )
                  : Row(
                children: [
                  Expanded(child: Text(
                    AppLocalization.of(context).trans(widget.label),
                    style: TextStyle(color: Styles.darkerBlue, fontSize: 14, fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textScaleFactor: ScreenUtil.calcTextScaleFactor(context),)),
                  SizedBox(width: 10,),
                  widget.value == null ? Container() : Text(
                    value,
                    style: TextStyle(color: Styles.blue, fontSize: 14, fontWeight: FontWeight.w500),
                    textScaleFactor: ScreenUtil.calcTextScaleFactor(context),),
                  SizedBox(width: 5,),
                  Icon(Icons.keyboard_arrow_right, size: 28, color: Colors.grey),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: widget.borderPadding),
              child: Divider(height: 1),
            )
          ],
        ),
      ),
      onClick: () {
        widget.onClick();
      },
    );
  }
}
