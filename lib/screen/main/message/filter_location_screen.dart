import 'package:esdc_emg/bloc/bloc.dart';
import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/row/item_divider.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:esdc_emg/widget/row/message_filter_location_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterLocationScreen extends StatefulWidget {
  @override
  _FilterLocationScreenState createState() => _FilterLocationScreenState();
}

class _FilterLocationScreenState extends State<FilterLocationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChildAppbar(
              title: 'filter_location',
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
                      ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => MessageFilterLocationRow(location: Globals.MESSAGE_LOCATIONS[index],),
                          separatorBuilder: (context, index) => ItemDivider(paddingLeft: 20),
                          itemCount: Globals.MESSAGE_LOCATIONS.length),
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
