import 'package:esdc_emg/config/style.dart';
import 'package:flutter/material.dart';

class AppCommentbox extends StatefulWidget {
  final TextEditingController controller;

  AppCommentbox({this.controller});

  @override
  _AppCommentboxState createState() => _AppCommentboxState();
}

class _AppCommentboxState extends State<AppCommentbox> {

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Styles.darkGray,
          width: 1,
        ),
      ),
      child: Container(
        height: 120,
        margin: const EdgeInsets.all(5),
        child: TextField(
          controller: widget.controller,
          maxLines: 5,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
          style: TextStyle(color: Styles.textBlack, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
