import 'package:esdc_emg/bloc/bloc.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/model/message_model.dart';
import 'package:esdc_emg/screen/main/message/filter_location_screen.dart';
import 'package:esdc_emg/screen/main/message/filter_topic_screen.dart';
import 'package:esdc_emg/util/message_util.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/button/icon_button.dart';
import 'package:esdc_emg/widget/row/category_label.dart';
import 'package:esdc_emg/widget/row/nonurgent_message_row.dart';
import 'package:esdc_emg/widget/row/setting_item_row.dart';
import 'package:esdc_emg/widget/row/urgent_message_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  String filterTopic = "all_topics";
  String filterLocation = "all_locations";

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
            onClick: () => openFilter(),
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
                  urgents == null || urgents.isEmpty ? Container() : CategoryLabel(label: 'PRIORITY\'s MESSAGE'),
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

  void openFilter() {
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
          height: 350,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text(
                AppLocalization.of(context).trans("filter_inbox"),
                style: TextStyle(
                    color: Styles.textBlack,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                AppLocalization.of(context).trans("customize_inbox_looks"),
                style: TextStyle(
                    color: Styles.textBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 20,),
              SettingItemRow(
                label: 'topic',
                value: filterTopic,
                onClick: () async {
                  String topic = await Navigator.push(context, MaterialPageRoute(builder: (context) => FilterTopicScreen(),));
                  if (topic != null) {
                    setState(() {
                      filterTopic = topic;
                    });
                    Navigator.pop(context);
                  }
                },
                backgroundColor: Colors.transparent,
                borderPadding: 0,
                paddingHorizontal: 0,
              ),
              SettingItemRow(
                label: 'location_specific',
                value: filterLocation,
                onClick: () async {
                  String location = await Navigator.push(context, MaterialPageRoute(builder: (context) => FilterLocationScreen(),));
                  if (location != null) {
                    setState(() {
                      filterLocation = location;
                    });
                    Navigator.pop(context);
                  }
                },
                backgroundColor: Colors.transparent,
                borderPadding: 0,
                paddingHorizontal: 0,
              ),
              SettingItemRow(
                label: 'sorting',
                value: 'new_old',
                onClick: () {

                },
                backgroundColor: Colors.transparent,
                borderPadding: 0,
                paddingHorizontal: 0,
              ),
            ],
          ),
        )
      ],),);
  }

  Widget buildUrgentMessages(List<MessageModel> allMessages) {
    List<MessageModel> messages = filterMessages(allMessages);
    return ListView.builder(
      itemCount: messages.length,
        physics: BouncingScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) => UrgentMessageRow(message: messages[index]),
    );
  }

  Widget buildNonUrgentMessages(List<MessageModel> allMessages) {
    List<MessageModel> messages = filterMessages(allMessages);
    return ListView.builder(
      itemCount: messages.length,
      physics: BouncingScrollPhysics(),
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) => NonUrgentMessageRow(message: messages[index]),
    );
  }

  List<MessageModel> filterMessages(List<MessageModel> messages) {
    return messages.where((element) => (filterTopic == 'all_topics' || element.category.toLowerCase().contains(filterTopic)) && (filterLocation == 'all_locations' || element.location == filterLocation)).toList();
  }
}