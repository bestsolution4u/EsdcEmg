import 'package:esdc_emg/config/style.dart';
import 'package:flutter/material.dart';

class AppInputbox extends StatefulWidget {

  final TextEditingController controller;

  AppInputbox({this.controller});

  @override
  _AppInputboxState createState() => _AppInputboxState();
}

class _AppInputboxState extends State<AppInputbox> {

  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
        height: 40,
        margin: const EdgeInsets.all(5),
        child: TextField(
          controller: widget.controller,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
