import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/model/message_model.dart';
import 'package:esdc_emg/screen/main/message_detail_screen.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class UrgentMessageRow extends StatefulWidget {

  final MessageModel message;

  UrgentMessageRow({this.message});

  @override
  _UrgentMessageRowState createState() => _UrgentMessageRowState();
}

class _UrgentMessageRowState extends State<UrgentMessageRow> {
  @override
  Widget build(BuildContext context) {
    return RippleComponent(
      onClick: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MessageDetailScreen(message: widget.message,),));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Styles.lightGray,
                width: 1,
              ),
            ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(child: Text(widget.message.title, style: TextStyle(color: Styles.red, fontSize: 14, fontWeight: FontWeight.w700),)),
                SizedBox(width: 5,),
                Container(
                  height: 10,
                  width: 10,
                  decoration: new BoxDecoration(
                    color: Styles.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ],
            )),
            SizedBox(width: 10,),
            Text(DateFormat('MMMM dd, yyyy').format(DateTime.parse(widget.message.effectiveDate)), style: TextStyle(color: Styles.darkGray, fontSize: 12, fontWeight: FontWeight.w400),),
            SizedBox(width: 2,),
            Icon(Icons.keyboard_arrow_right, size: 32, color: Styles.darkGray,)
          ],
        ),
      ),
    );
  }
}
