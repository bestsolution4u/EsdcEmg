import 'package:esdc_emg/bloc/bloc.dart';
import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/model/message_model.dart';
import 'package:esdc_emg/model/setting_model.dart';
import 'package:esdc_emg/screen/main/message/filter_location_screen.dart';
import 'package:esdc_emg/screen/main/message/filter_topic_screen.dart';
import 'package:esdc_emg/util/screen_util.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/button/icon_button.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:esdc_emg/widget/row/item_divider.dart';
import 'package:esdc_emg/widget/row/message_item_row.dart';
import 'package:esdc_emg/widget/row/setting_item_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: "Message list screen loaded",
      child: Scaffold(
        appBar: ESDCAppbar.renderMainAppbar(
            title: 'title_msg',
            icon: 'asset/image/tab-messages-active.svg',
            context: context,
            action: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Stack(
                children: [
                  AppIconButton(
                    sematicLabel: AppLocalization.of(context).trans('filtered_inbox'),
                    icon: SvgPicture.asset(
                      'asset/image/setting.svg',
                      color: Styles.darkerBlue,
                      allowDrawingOutsideViewBox: true,
                      height: 24,
                    ),
                    onClick: () => openFilter(),
                    rippleRadius: 36,
                    padding: 12,
                  ),
                  Positioned(
                    top: 0,
                    right: 8,
                    child: BlocBuilder<SettingBloc, SettingState>(
                      builder: (context, state) {
                        if (state is !SettingLoadSuccessState) return Container();
                        SettingModel settingModel = (state as SettingLoadSuccessState).settings;
                        List<String> topicFilters = settingModel.messageCategory.split(",").where((element) => element != null && element.isNotEmpty && element != Globals.DEFAULT_MESSAGE_CATEGORY).toList();
                        List<String> locationFilters = settingModel.messageLocation.split(",").where((element) => element != null && element.isNotEmpty && element != Globals.MESSAGE_LOCATIONS[0]).toList();
                        if (topicFilters.length + locationFilters.length > 0) return Container(
                            width: 12,
                            height: 12,
                            margin: const EdgeInsets.only(top: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Styles.blue
                            ));
                        return Container();
                      },
                    ),)
                ],
              ),
            )
        ),
        body: BlocBuilder<MessageBloc, MessageState>(
          builder: (context, state) {
            if (state is MessageLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MessageLoadFailureState) {
              return Center(
                child: Text('Error', textScaleFactor: ScreenUtil.calcTextScaleFactor(context),),
              );
            } else {
              List<MessageModel> messages = (state as MessageLoadSuccessState).messages;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(height: 1, color: Styles.bgGrey,),
                    buildFilterCount(),
                    buildMessages(messages),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildFilterCount() {
    return BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          if (state is !SettingLoadSuccessState) return Container();
          SettingModel settingModel = (state as SettingLoadSuccessState).settings;
          List<String> topicFilters = settingModel.messageCategory.split(",").where((element) => element != null && element.isNotEmpty && element != Globals.DEFAULT_MESSAGE_CATEGORY).toList();
          List<String> locationFilters = settingModel.messageLocation.split(",").where((element) => element != null && element.isNotEmpty && element != Globals.MESSAGE_LOCATIONS[0]).toList();
          int count = topicFilters.length + locationFilters.length;
          if (count > 0) return RippleComponent(
            onClick: () => openFilter(),
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  Text(
                    AppLocalization.of(context).trans('you_have') + count.toString() + AppLocalization.of(context).trans('message_filters_applied'),
                    style: TextStyle(fontSize: 12, color: Styles.blue),
                    textScaleFactor: ScreenUtil.calcTextScaleFactor(context),),
                  SizedBox(height: 10,),
                  Divider(height: 1, color: Styles.bgGrey,),
                ],
              ),
            ),
          );
          return Container();
        },
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
        BlocBuilder<SettingBloc, SettingState>(
            builder: (context, state) {
              if (state is !SettingLoadSuccessState) return Container();
              SettingModel settingModel = (state as SettingLoadSuccessState).settings;
              return Container(
                height: ScreenUtil.calcTextScaleFactor(context) > 1 ? 400 : 350,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppLocalization.of(context).trans("my_preferences"),
                          style: TextStyle(
                              color: Styles.darkerBlue,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                          textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
                        ),
                        Spacer(),
                        AppIconButton(
                          icon: Icon(Icons.close, color: Styles.blue, size: 24,),
                          padding: 12,
                          rippleRadius: 24,
                          onClick: () => Navigator.pop(context),
                          sematicLabel: "close",
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppLocalization.of(context).trans("customize_inbox_looks"),
                      style: TextStyle(
                          color: Styles.darkerBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
                    ),
                    SizedBox(height: 10,),
                    Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SettingItemRow(
                                label: 'topic',
                                value: settingModel.messageCategory,
                                isTopic: true,
                                onClick: () {
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => FilterTopicScreen(),));
                                },
                                backgroundColor: Colors.transparent,
                                borderPadding: 0,
                                paddingHorizontal: 0,
                                sortKey: 10,
                              ),
                              SettingItemRow(
                                label: 'location_specific',
                                value: settingModel.messageLocation,
                                isLocation: true,
                                onClick: () {
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => FilterLocationScreen(),));
                                },
                                backgroundColor: Colors.transparent,
                                borderPadding: 0,
                                paddingHorizontal: 0,
                                sortKey: 11,
                              ),
                            ],
                          ),
                        )
                    )
                  ],
                ),
              );
            },
        ),
      ],),);
  }

  Widget buildMessages(List<MessageModel> allMessages) {
    return BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          List<MessageModel> messages = [];
          if (state is !SettingLoadSuccessState) {
            messages = allMessages;
          } else {
            SettingModel settings = (state as SettingLoadSuccessState).settings;
            messages = filterMessages(allMessages, settings.messageCategory, settings.messageLocation);
          }
          return ListView.separated(
            itemCount: messages.length,
            physics: BouncingScrollPhysics(),
            primary: false,
            shrinkWrap: true,
            itemBuilder: (context, index) => MessageItemRow(message: messages[index]),
            separatorBuilder: (context, index) => ItemDivider(),
          );
        },);
  }

  List<MessageModel> filterMessages(List<MessageModel> messages, String filterTopic, String filterLocation) {
    return messages.where((element) {
      List<String> catElement = element.category.split(",");
      List<String> catFilter = filterTopic.split(",");
      bool matchedTopic = false;
      if (filterTopic == Globals.DEFAULT_MESSAGE_CATEGORY) {
        matchedTopic = true;
      } else {
        catElement.forEach((elementCat) {
          catFilter.forEach((elementFilterCat) {
            if (elementCat.toLowerCase().contains(elementFilterCat)) matchedTopic = true;
          });
        });
      }

      List<String> locationElement = element.audience.split(",");
      List<String> locationFilter = filterLocation.split(",");
      bool matchedLocation = false;
      if (locationFilter.contains(Globals.MESSAGE_LOCATIONS[0]) || locationElement.contains(Globals.MESSAGE_LOCATIONS[0])) {
        matchedLocation = true;
      } else {
        locationElement.forEach((elementLoc) {
          locationFilter.forEach((elementFilterLoc) {
            if (elementLoc == elementFilterLoc) matchedLocation = true;
          });
        });
      }

      return matchedTopic && matchedLocation;
    }).toList();
  }
}
