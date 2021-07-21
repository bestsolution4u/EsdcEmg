import 'package:esdc_emg/bloc/bloc.dart';
import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/util/screen_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageFilterLocationRow extends StatefulWidget {

  final String location;
  final double order;

  MessageFilterLocationRow({this.location, this.order});

  @override
  _MessageFilterLocationRowState createState() => _MessageFilterLocationRowState();
}

class _MessageFilterLocationRowState extends State<MessageFilterLocationRow> {

  SettingBloc _settingBloc;
  bool _isEnabled = false;

  @override
  void initState() {
    super.initState();
    _settingBloc = BlocProvider.of<SettingBloc>(context);
    if (_settingBloc.state is SettingLoadSuccessState) {
      update((_settingBloc.state as SettingLoadSuccessState).settings.messageLocation);
    }
  }

  void update(String locations) {
    bool selected = false;
    List<String> locList = locations.split(',');
    if ((locList != null && locList.isNotEmpty && locList.contains(widget.location)) || locList.contains(Globals.MESSAGE_LOCATIONS[0])) {
      selected = true;
    }
    setState(() {
      _isEnabled = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is SettingLoadSuccessState) {
          update(state.settings.messageLocation);
        }
      },
      child: Semantics(
        sortKey: OrdinalSortKey(widget.order),
        checked: _isEnabled,
        label: AppLocalization.of(context).trans(widget.location),
        excludeSemantics: true,
        onTap: () {
          _settingBloc.add(SettingUpdateMessageLocationEvent(messageLocation: widget.location, enabled: !_isEnabled));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                    AppLocalization.of(context).trans(widget.location),
                    style: TextStyle(fontSize: 16, color: Styles.darkerBlue),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    textScaleFactor: ScreenUtil.calcTextScaleFactor(context),)
              ),
              SizedBox(width: 20,),
              CupertinoSwitch(
                  value: _isEnabled,
                  activeColor: Styles.blue,
                  onChanged: (value) {
                    _settingBloc.add(SettingUpdateMessageLocationEvent(messageLocation: widget.location, enabled: value));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
