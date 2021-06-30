import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/util/screen_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageFilterRow extends StatefulWidget {

  final String value;
  final bool selected;
  final Function(bool) onChange;

  MessageFilterRow({@required this.value, this.selected = false, this.onChange});

  @override
  _MessageFilterRowState createState() => _MessageFilterRowState();
}

class _MessageFilterRowState extends State<MessageFilterRow> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
              child: Text(
                AppLocalization.of(context).trans(widget.value),
                style: TextStyle(fontSize: 16, color: Styles.darkerBlue),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textScaleFactor: ScreenUtil.calcTextScaleFactor(context),)
          ),
          SizedBox(width: 20,),
          CupertinoSwitch(
            value: widget.selected,
            activeColor: Styles.blue,
            onChanged: (value) => widget.onChange(value),)
        ],
      ),
    );
  }
}
