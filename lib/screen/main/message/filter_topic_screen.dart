import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:flutter/material.dart';

class FilterTopicScreen extends StatefulWidget {
  @override
  _FilterTopicScreenState createState() => _FilterTopicScreenState();
}

class _FilterTopicScreenState extends State<FilterTopicScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChildAppbar(
                title: 'filter_topic',
              ),
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30,),
                        ItemSelectorRow(title: 'all_topics', onClick: () => Navigator.pop(context, 'all_topics'),),
                        ListView.separated(
                          primary: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => ItemSelectorRow(title: Globals.MESSAGE_CATEGORIES[index], onClick: () => Navigator.pop(context, Globals.MESSAGE_CATEGORIES[index]),),
                            separatorBuilder: (context, index) => SizedBox(height: 5,),
                            itemCount: Globals.MESSAGE_CATEGORIES.length)
                      ],
                    ),
                  ))
            ],
          ),
        )
    );
  }
}
