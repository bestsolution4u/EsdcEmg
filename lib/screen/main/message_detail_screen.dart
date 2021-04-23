import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/model/message_model.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/button/bordered_button.dart';
import 'package:esdc_emg/widget/button/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class MessageDetailScreen extends StatefulWidget {

  final MessageModel message;

  MessageDetailScreen({this.message});

  @override
  _MessageDetailScreenState createState() => _MessageDetailScreenState();
}

class _MessageDetailScreenState extends State<MessageDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChildAppbar(
            title: widget.message.title,
            action: AppIconButton(
              icon: SvgPicture.asset(
                'asset/image/more.svg',
                color: Styles.darkGray,
                allowDrawingOutsideViewBox: true,
                height: 24,
              ),
              padding: 12,
              rippleRadius: 24,
              onClick: () => openMore(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              DateFormat('MMMM dd, yyyy').format(DateTime.parse(widget.message.effectiveDate)),
              style: TextStyle(color: Styles.textBlack, fontSize: 14),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              widget.message.category != null ? widget.message.category : '',
              style: TextStyle(color: Styles.textBlack, fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              widget.message.message,
              style: TextStyle(color: Styles.textBlack, fontSize: 16),
              textAlign: TextAlign.start,
            ),
          )
        ],
      ),
    ));
  }

  void openMore() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) => Wrap(children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'More actions',
                  style: TextStyle(
                      color: Styles.textBlack,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Customize actions for this message.',
                  style: TextStyle(
                      color: Styles.textBlack,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                BorderedButton(title: 'Mark as unread', onClick: () {},),
                BorderedButton(title: 'Share this page', onClick: () {},),
                BorderedButton(title: 'Delete', color: Styles.red, onClick: () {},),
              ],
            ),
          )
        ],),);
  }
}
