import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/message/message_bloc.dart';
import '../../bloc/message/message_state.dart';
import '../../config/style.dart';
import '../../localization/app_localization.dart';
import '../../model/message_model.dart';
import '../../screen/main/message/message_detail_screen.dart';
import '../button/ripple_component.dart';

class MessageItemRow extends StatelessWidget {
  final MessageModel message;

  MessageItemRow({this.message});

  @override
  Widget build(BuildContext context) {
    return RippleComponent(
      onClick: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MessageDetailScreen(message: message),));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<MessageBloc, MessageState>(builder: (context, state) {
              if (state is! MessageLoadSuccessState) return SizedBox(width: 12);
              List<int> readMessages = (state as MessageLoadSuccessState).readMessages;
              bool read = false;
              if (readMessages.contains(message.id)) read = true;
              else read = false;
              return Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(top: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: !read ? Styles.blue : Colors.white
                ),
              );
            },),
            SizedBox(
              width: 15,
            ),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                    child: Text(
                      AppLocalization.currentLanguage == 'fr' ? message.titleFr : message.title,
                      style: TextStyle(color: Styles.darkerBlue, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                Text(DateFormat(AppLocalization.currentLanguage == 'fr' ? 'dd MMMM yyyy' : 'MMMM dd, yyyy', AppLocalization.currentLanguage).format(DateTime.parse(message.effectiveDate)), style: TextStyle(color: Styles.darkerBlue, fontSize: 12, fontWeight: FontWeight.w400),),
              ],
            )),
            message.urgentInd == 'Urgent' ? Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Styles.red,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(AppLocalization.of(context).trans('urgent'), style: TextStyle(color: Colors.white, fontSize: 10),),
              ),
            ) : Container(),
            Padding(padding: const EdgeInsets.only(top: 10, left: 10), child: Icon(Icons.keyboard_arrow_right, size: 24, color: Colors.grey,),)
          ],
        ),
      ),
    );
  }
}
