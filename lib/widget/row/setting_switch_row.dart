import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/util/screen_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingSwitchRow extends StatefulWidget {

  final String label;
  final bool value;
  final Function(bool) onChange;

  SettingSwitchRow({this.label, this.value, this.onChange});

  @override
  _SettingSwitchRowState createState() => _SettingSwitchRowState();
}

class _SettingSwitchRowState extends State<SettingSwitchRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(child: Text(
                  AppLocalization.of(context).trans(widget.label),
                  style: TextStyle(color: Styles.textBlack, fontSize: 14, fontWeight: FontWeight.w500),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: ScreenUtil.calcTextScaleFactor(context),)),
                SizedBox(width: 10,),
                Transform.scale(
                    scale: 0.8,
                  child: CupertinoSwitch(
                    value: widget.value,
                    onChanged: (value) => widget.onChange(value),
                    activeColor: Styles.purple,
                    trackColor: Colors.grey,),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Divider(height: 1),
          )
        ],
      ),
    );
  }
}
