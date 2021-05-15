import 'package:esdc_emg/bloc/bloc.dart';
import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterTopicScreen extends StatefulWidget {
  @override
  _FilterTopicScreenState createState() => _FilterTopicScreenState();
}

class _FilterTopicScreenState extends State<FilterTopicScreen> {

  SettingBloc _settingBloc;

  @override
  void initState() {
    super.initState();
    _settingBloc = BlocProvider.of<SettingBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                      ItemSelectorRow(title: Globals.DEFAULT_MESSAGE_CATEGORY, onClick: () {
                        _settingBloc.add(SettingUpdateMessageCategoryEvent(messageCategory: Globals.DEFAULT_MESSAGE_CATEGORY));
                        Navigator.pop(context);
                      },),
                      ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => ItemSelectorRow(title: Globals.MESSAGE_CATEGORIES[index], onClick: () {
                            _settingBloc.add(SettingUpdateMessageCategoryEvent(messageCategory: Globals.MESSAGE_CATEGORIES[index]));
                            Navigator.pop(context);
                          }),
                          separatorBuilder: (context, index) => SizedBox(height: 5,),
                          itemCount: Globals.MESSAGE_CATEGORIES.length)
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
