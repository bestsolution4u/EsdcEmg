import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esdc_emg/bloc/bloc.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/model/message_model.dart';
import 'package:esdc_emg/util/screen_util.dart';
import 'package:esdc_emg/widget/appbar/message_appbar.dart';
import 'package:esdc_emg/widget/button/bordered_button.dart';
import 'package:esdc_emg/widget/button/icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class MessageDetailScreen extends StatefulWidget {

  final MessageModel message;

  MessageDetailScreen({this.message});

  @override
  _MessageDetailScreenState createState() => _MessageDetailScreenState();
}

class _MessageDetailScreenState extends State<MessageDetailScreen> {

  final firestore = FirebaseFirestore.instance;
  MessageBloc _messageBloc;

  @override
  void initState() {
    super.initState();
    _messageBloc = BlocProvider.of<MessageBloc>(context);
    _messageBloc.add(MessageStatusUpdateEvent(messageID: widget.message.id, read: true));
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = DateTime.parse(widget.message.expiredDate).difference(DateTime.now());
    String strExpDuration = "";
    if (duration.inHours < 0) {
      strExpDuration = AppLocalization.of(context).trans("today");
    } else {
      int days = ((duration.inHours + DateTime.now().hour) / 24).floor();
      if (days > 0) {
        strExpDuration = AppLocalization.of(context).trans("in") + days.toString() + " " + AppLocalization.of(context).trans("days");
      } else {
        strExpDuration = AppLocalization.of(context).trans("today");
      }
    }
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: "Message detail screen loaded",
      value: "Message detail screen loaded",
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MessageAppBar(
                message: widget.message,
                action: AppIconButton(
                  icon: SvgPicture.asset(
                    'asset/image/more.svg',
                    color: Styles.darkerBlue,
                    allowDrawingOutsideViewBox: true,
                    height: 24,
                  ),
                  padding: 12,
                  rippleRadius: 24,
                  onClick: () => openMore(),
                ),
              ),
              Expanded(child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        AppLocalization.currentLanguage == 'fr' ? widget.message.messageFr : widget.message.message,
                        style: TextStyle(color: Styles.textBlack, fontSize: 16),
                        textAlign: TextAlign.start,
                        textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        AppLocalization.of(context).trans('note_expiration_date') + strExpDuration,
                        style: TextStyle(color: Styles.textBlack, fontSize: 12),
                        textAlign: TextAlign.start,
                        textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  void openMore() {
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
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalization.of(context).trans('customize_actions_for_message'),
                  style: TextStyle(
                      color: Styles.darkerBlue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
                ),
                SizedBox(
                  height: 10,
                ),
                BorderedButton(title: AppLocalization.of(context).trans('mark_as_unread'), onClick: () {
                  _messageBloc.add(MessageStatusUpdateEvent(messageID: widget.message.id, read: false));
                  Navigator.pop(context);
                },),
                /*BorderedButton(title: 'Share this page', onClick: () {
                  Navigator.pop(context);
                },),*/
                BorderedButton(
                  title: AppLocalization.of(context).trans('delete'),
                  buttonColor: Styles.pink,
                  borderColor: Styles.pink,
                  color: Styles.red,
                  onClick: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        title: new Text(
                            AppLocalization.of(context).trans('delete_message'),
                          textScaleFactor: ScreenUtil.calcTextScaleFactor(context),),
                        content: new Text(
                            AppLocalization.of(context).trans('confirm_delete_message'),
                          textScaleFactor: ScreenUtil.calcTextScaleFactor(context),),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            child: Text(
                                AppLocalization.of(context).trans('continue'),
                              textScaleFactor: ScreenUtil.calcTextScaleFactor(context),),
                            onPressed: () {
                              _messageBloc.add(MessageDeleteEvent(messageID: widget.message.id));
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoDialogAction(
                            child: Text(AppLocalization.of(context).trans('cancel'),
                              textScaleFactor: ScreenUtil.calcTextScaleFactor(context),),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      )
                  );
                },),
              ],
            ),
          )
        ],),);
  }
}
