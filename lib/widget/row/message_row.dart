import 'package:esdc_emg/bloc/bloc.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/model/message_model.dart';
import 'package:esdc_emg/screen/main/message/message_detail_screen.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MessageRow extends StatefulWidget {

  final MessageModel message;
  final bool isUrgent;

  MessageRow({this.message, this.isUrgent = true});

  @override
  _MessageRowState createState() => _MessageRowState();
}

class _MessageRowState extends State<MessageRow> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RippleComponent(
      onClick: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MessageDetailScreen(message: widget.message),));
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
            Expanded(child: BlocBuilder<MessageBloc, MessageState>(
              builder: (context, state) {
                if (state is! MessageLoadSuccessState) return Container();
                List<int> readMessages = (state as MessageLoadSuccessState).readMessages;
                bool read = false;
                if (readMessages.contains(widget.message.id)) read = true;
                else read = false;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(child: Text(AppLocalization.currentLanguage == 'fr' ? widget.message.titleFr : widget.message.title, style: TextStyle(color: read ? Colors.black : widget.isUrgent ? Styles.red : Styles.purple, fontSize: 14, fontWeight: read ? FontWeight.w400 : FontWeight.w700),)),
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
                );
              },
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
