import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esdc_emg/bloc/app_bloc.dart';
import 'package:esdc_emg/bloc/bloc.dart';
import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/pref_params.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/model/message_model.dart';
import 'package:esdc_emg/model/setting_model.dart';
import 'package:esdc_emg/screen/main/socialmedia/social_media_screen.dart';
import 'package:esdc_emg/screen/main/video/video_hub_screen.dart';
import 'package:esdc_emg/util/preference_helper.dart';
import 'package:esdc_emg/widget/tabbar/esdc_tabbar.dart';
import 'package:esdc_emg/widget/tabbar/main_tab_item.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'dashboard/dashboard_screen.dart';
import 'employee/employee_screen.dart';
import 'message/message_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'esdc_fcm_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final int tabLength = 5;
  TabController tabController;
  int currentTabIndex = 0;
  FirebaseFirestore firestore;

  @override
  void initState() {
    super.initState();
    setupFCM();
    tabController = TabController(
      initialIndex: 0,
      length: tabLength,
      vsync: this,
    )..addListener(handleTabController);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  void handleTabController() {
    currentTabIndex = tabController.index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: AppMainTabBarView(
            controller: tabController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              DashboardScreen(
                onUrgentClick: () {
                  tabController.animateTo(1);
                },
              ),
              MessageScreen(),
              EmployeeScreen(),
              SocialMediaScreen(),
              VideoHubScreen()
            ],
          ),
          bottomNavigationBar: Container(
            height: Platform.isIOS ? 70 : 60,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 3,
                  blurRadius: 5,
                ),
              ],
            ),
            child: AppMainTabBar(
              indicatorColor: Colors.white,
              controller: tabController,
              activeBackgroundColor: Colors.white,
              inactiveBackgroundColor: Colors.white,
              indicatorWeight: 0.1,
              tabs: [
                MainTabItem(
                  title: 'app_title_home',
                  image: 'asset/image/nav-icon-home.svg',
                  imageInactive: 'asset/image/tab-home.svg',
                  selected: currentTabIndex == 0,
                ),
                MainTabItem(
                  title: 'title_msg',
                  image: 'asset/image/tab-messages-active.svg',
                  imageInactive: 'asset/image/tab-messages.svg',
                  selected: currentTabIndex == 1,
                  badge: BlocBuilder<MessageBloc, MessageState>(
                    builder: (context, msgState) {
                      if (msgState is! MessageLoadSuccessState) {
                        return Container(
                          width: 0,
                          height: 0,
                        );
                      } else {
                        return BlocBuilder<SettingBloc, SettingState>(
                          builder: (context, settingState) {
                            if (settingState is! SettingLoadSuccessState)
                              return Container(
                                width: 0,
                                height: 0,
                              );
                            List<MessageModel> messages = (msgState as MessageLoadSuccessState).messages;
                            SettingModel settings = (settingState as SettingLoadSuccessState).settings;
                            List<int> readMessages = (msgState as MessageLoadSuccessState).readMessages;
                            List<MessageModel> unreadMessages = messages.where((element) {
                              String filterTopic = settings.messageCategory;
                              String filterLocation = settings.messageLocation;
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

                              return !readMessages.contains(element.id) && matchedTopic && matchedLocation;
                            }).toList();
                            if (unreadMessages.length == 0)
                              return Container(
                                width: 0,
                                height: 0,
                              );
                            return Positioned(
                              top: 0,
                              right: 0,
                              child: Transform.translate(
                                offset: Offset(2.0, -3.0),
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: Styles.red),
                                  child: Center(
                                    child: Text(
                                      unreadMessages.length.toString(),
                                      style: TextStyle(color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                MainTabItem(
                  title: 'title_emply',
                  image: 'asset/image/tab-employees-active.svg',
                  imageInactive: 'asset/image/tab-employees.svg',
                  selected: currentTabIndex == 2,
                ),
                MainTabItem(
                  title: 'title_soci_medi',
                  image: 'asset/image/tab-social-active.svg',
                  imageInactive: 'asset/image/tab-social.svg',
                  selected: currentTabIndex == 3,
                ),
                MainTabItem(
                  title: 'video_hub',
                  image: 'asset/image/youtube-selected.svg',
                  imageInactive: 'asset/image/youtube-unselected.svg',
                  selected: currentTabIndex == 4,
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> setupFCM() async {
    FirebaseMessaging fcmMessaging = FirebaseMessaging.instance;
    fcmMessaging.getToken().then((token) => print("FCM Token: " + token));
    await fcmMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await fcmMessaging.subscribeToTopic(Globals.FCM_TOPIC_MESSAGE_CREATED);
    await fcmMessaging.subscribeToTopic(Globals.FCM_TOPIC_MESSAGE_UPDATED);
    await fcmMessaging.subscribeToTopic(Globals.FCM_TOPIC_MESSAGE_DELETED);
    fcmMessaging.getInitialMessage().then((RemoteMessage message) {
      if (message != null) {
        print("Initial Messages: " + message.messageId);
      }
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'esdc_fcm_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("----------------- onMessage ----------------");
      print("topic: " + message.from);
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  icon: 'notification_icon',
                ),
                iOS: IOSNotificationDetails(
                  presentAlert: true,
                  presentSound: true,
                )
            ));
      }
      AppBloc.messageBloc.add(MessageRefreshEvent());
    });
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message");
  }
}
