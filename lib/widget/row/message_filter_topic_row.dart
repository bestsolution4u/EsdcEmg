import 'package:esdc_emg/bloc/bloc.dart';
import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/util/screen_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageFilterTopicRow extends StatefulWidget {
  final String topic;
  final double order;

  MessageFilterTopicRow({this.topic, this.order});

  @override
  _MessageFilterTopicRowState createState() => _MessageFilterTopicRowState();
}

class _MessageFilterTopicRowState extends State<MessageFilterTopicRow> {
  SettingBloc _settingBloc;
  bool _isEnabled = false;

  @override
  void initState() {
    super.initState();
    _settingBloc = BlocProvider.of<SettingBloc>(context);
    if (_settingBloc.state is SettingLoadSuccessState) {
      update((_settingBloc.state as SettingLoadSuccessState)
          .settings
          .messageCategory);
    }
  }

  void update(String categories) {
    bool selected = false;
    List<String> catList = categories.split(',');
    if ((catList != null &&
            catList.isNotEmpty &&
            catList.contains(widget.topic)) ||
        catList.contains(Globals.DEFAULT_MESSAGE_CATEGORY)) {
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
          update(state.settings.messageCategory);
        }
      },
      child: MergeSemantics(
          child: ListTile(
              onTap: () {
                _settingBloc.add(SettingUpdateMessageCategoryEvent(
                    messageCategory: widget.topic, enabled: !_isEnabled));
              },
              title: Text(
                AppLocalization.of(context).trans(widget.topic),
                style: TextStyle(fontSize: 16, color: Styles.darkerBlue),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
              ),
              trailing: CupertinoSwitch(
                  value: _isEnabled,
                  activeColor: Styles.blue,
                  trackColor: Styles.bgSwitchOff,
                  onChanged: (value) {
                    _settingBloc.add(SettingUpdateMessageCategoryEvent(
                        messageCategory: widget.topic, enabled: value));
                  }))),
    );
  }
}
