import 'package:esdc_emg/bloc/bloc.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/model/message_model.dart';
import 'package:esdc_emg/util/message_util.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/button/icon_button.dart';
import 'package:esdc_emg/widget/row/category_label.dart';
import 'package:esdc_emg/widget/row/nonurgent_message_row.dart';
import 'package:esdc_emg/widget/row/urgent_message_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ESDCAppbar.generateMainAppbar(
          title: "Messages",
          action: AppIconButton(
            icon: SvgPicture.asset(
              'asset/image/setting.svg',
              color: Styles.textBlack,
              allowDrawingOutsideViewBox: true,
              height: 24,
            ),
            onClick: () {},
            rippleRadius: 36,
            padding: 12,
          )),
      body: BlocBuilder<MessageBloc, MessageState>(
        builder: (context, state) {
          if (state is MessageLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MessageLoadFailureState) {
            return Center(
              child: Text('Error'),
            );
          } else {
            List<MessageModel> messages = (state as MessageLoadSuccessState).messages;
            List<MessageModel> urgents = MessageUtils.filterUrgentMessages(messages);
            List<MessageModel> nonUrgents = MessageUtils.filterNonUrgentMessages(messages);
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  urgents == null || urgents.isEmpty ? Container() : CategoryLabel(label: 'PRIORITY MESSAGE'),
                  urgents == null || urgents.isEmpty ? Container() : buildUrgentMessages(urgents),
                  nonUrgents == null || nonUrgents.isEmpty ? Container() : CategoryLabel(label: 'MESSAGE TO EMPLOYEES'),
                  nonUrgents == null || nonUrgents.isEmpty ? Container() : buildNonUrgentMessages(nonUrgents),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildUrgentMessages(List<MessageModel> messages) {
    return ListView.builder(
      itemCount: messages.length,
        physics: BouncingScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) => UrgentMessageRow(message: messages[index]),
    );
  }

  Widget buildNonUrgentMessages(List<MessageModel> messages) {
    return ListView.builder(
      itemCount: messages.length,
      physics: BouncingScrollPhysics(),
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) => NonUrgentMessageRow(message: messages[index]),
    );
  }
}
