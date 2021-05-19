import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/row/item_divider.dart';
import 'package:esdc_emg/widget/row/message_filter_topic_row.dart';
import 'package:flutter/material.dart';

class FilterTopicScreen extends StatefulWidget {
  @override
  _FilterTopicScreenState createState() => _FilterTopicScreenState();
}

class _FilterTopicScreenState extends State<FilterTopicScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChildAppbar(
              title: 'filter_topic',
              showDivider: false,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Text(AppLocalization.of(context).trans('filter_message_desc'), style: TextStyle(color: Styles.darkerBlue, fontSize: 16),),),
            ItemDivider(paddingLeft: 0,),
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MessageFilterTopicRow(topic: Globals.DEFAULT_MESSAGE_CATEGORY),
                      ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => MessageFilterTopicRow(topic: Globals.MESSAGE_CATEGORIES[index]),
                          separatorBuilder: (context, index) => ItemDivider(paddingLeft: 20),
                          itemCount: Globals.MESSAGE_CATEGORIES.length),
                      ItemDivider(paddingLeft: 0,),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
