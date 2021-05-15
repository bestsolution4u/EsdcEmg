import 'package:esdc_emg/bloc/bloc.dart';
import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterLocationScreen extends StatefulWidget {
  @override
  _FilterLocationScreenState createState() => _FilterLocationScreenState();
}

class _FilterLocationScreenState extends State<FilterLocationScreen> {

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
              title: 'filter_location',
            ),
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30,),
                      ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => ItemSelectorRow(title: AppLocalization.of(context).trans(Globals.MESSAGE_LOCATIONS[index]), translate: false, onClick: () {
                            _settingBloc.add(SettingUpdateMessageLocationEvent(messageLocation: Globals.MESSAGE_LOCATIONS[index]));
                            Navigator.pop(context);
                          }),
                          separatorBuilder: (context, index) => SizedBox(height: 5,),
                          itemCount: Globals.MESSAGE_LOCATIONS.length),
                      SizedBox(height: 30,)
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
