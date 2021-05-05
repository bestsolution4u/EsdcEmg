import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:flutter/material.dart';

class FilterLocationScreen extends StatefulWidget {
  @override
  _FilterLocationScreenState createState() => _FilterLocationScreenState();
}

class _FilterLocationScreenState extends State<FilterLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChildAppbar(
                title: AppLocalization.of(context).trans('filter_location'),
              ),
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30,),
                        ItemSelectorRow(title: AppLocalization.of(context).trans('all_locations'), onClick: () => Navigator.pop(context, 'all_locations'),),
                        ListView.separated(
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => ItemSelectorRow(title: Globals.MESSAGE_LOCATIONS[index], onClick: () => Navigator.pop(context, Globals.MESSAGE_LOCATIONS[index]),),
                            separatorBuilder: (context, index) => SizedBox(height: 5,),
                            itemCount: Globals.MESSAGE_LOCATIONS.length),
                        SizedBox(height: 30,)
                      ],
                    ),
                  ))
            ],
          ),
        )
    );
  }
}