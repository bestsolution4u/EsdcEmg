import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/model/message_model.dart';
import 'file:///D:/Projects/Flutter/EsdcEmg/esdc_emg/lib/screen/main/message/message_detail_screen.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NonUrgentMessageRow extends StatefulWidget {

  final MessageModel message;

  NonUrgentMessageRow({this.message});

  @override
  _NonUrgentMessageRowState createState() => _NonUrgentMessageRowState();
}

class _NonUrgentMessageRowState extends State<NonUrgentMessageRow> {

  bool read = false;
  final firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    firestore.collection("message").snapshots().listen((event) {
      event.docChanges.forEach((res) {
        if (res.doc.id == widget.message.id.toString()) {
          if (res.type == DocumentChangeType.added) {
            setState(() {
              read = (res.doc.data())['read'];
            });
          } else if (res.type == DocumentChangeType.modified) {
            setState(() {
              read = (res.doc.data())['read'];
            });
          } else if (res.type == DocumentChangeType.removed) {
            setState(() {
              read = false;
            });
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RippleComponent(
      onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MessageDetailScreen(message: widget.message,),)),
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
                Flexible(child: Text(widget.message.title, style: TextStyle(color: read ? Colors.black : Styles.purple, fontSize: 14, fontWeight: read ? FontWeight.w400 : FontWeight.w700),)),
                SizedBox(width: 5,),
                !read ? Container(
                  height: 10,
                  width: 10,
                  decoration: new BoxDecoration(
                    color: Styles.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ) : Container(),
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
