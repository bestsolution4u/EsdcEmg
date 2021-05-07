import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esdc_emg/bloc/app_bloc.dart';
import 'package:esdc_emg/bloc/bloc.dart';
import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/model/message_model.dart';
import 'package:esdc_emg/screen/main/socialmedia/social_media_screen.dart';
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

  final int tabLength = 4;
  TabController tabController;
  int currentTabIndex = 0;
  FirebaseFirestore firestore;
  List<String> readMessages = [];

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
        length: 4,
        child: Scaffold(
          body: AppMainTabBarView(
            controller: tabController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              DashboardScreen(onUrgentClick: () {
                tabController.animateTo(1);
              },),
              MessageScreen(),
              EmployeeScreen(),
              SocialMediaScreen()
            ],
          ),
          bottomNavigationBar: Container(
            height: 70,
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
              labelColor: Styles.purple,
              unselectedLabelColor: Styles.textBlack,
              tabs: [
                MainTabItem(title: 'app_title_home', image: 'asset/image/star.svg', selected: currentTabIndex == 0,),
                MainTabItem(title: 'title_msg', image: 'asset/image/mail.svg', selected: currentTabIndex == 1, badge: BlocBuilder<MessageBloc, MessageState>(
                  builder: (context, msgState) {
                    if (msgState is MessageLoadingState || msgState is MessageLoadFailureState) {
                      return Container(width: 0, height: 0,);
                    } else {
                      int unreadCount = 0;
                      List<MessageModel> messages = (msgState as MessageLoadSuccessState).messages;
                      for (int i = 0; i < messages.length; i++) {
                        if (!readMessages.contains(messages[i].id.toString())) {
                          unreadCount++;
                        }
                      }
                      if (unreadCount == 0) return Container(width: 0, height: 0,);
                      return Positioned(
                        top: 0,
                          right: 0,
                          child: Transform.translate(
                            offset: Offset(8.0, -8.0),
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Styles.red
                              ),
                              child: Center(
                                child: Text(unreadCount.toString(), style: TextStyle(color: Colors.white, fontSize: 10),),
                              ),
                            ),
                          ),);
                    }
                  },
                ),),
                MainTabItem(title: 'title_emply', image: 'asset/image/user.svg', selected: currentTabIndex == 2,),
                MainTabItem(title: 'title_soci_medi', image: 'asset/image/sound.svg', selected: currentTabIndex == 3,),
              ],
            ),
          ),
        )
    );
  }

  Future<void> setupFCM() async {
    await Firebase.initializeApp();
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
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("----------------- onMessage ----------------");
      print("topic: " + message.from);
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: 'launch_background',
              ),
            ));
      }
      AppBloc.messageBloc.add(MessageRefreshEvent());
    });

    firestore = FirebaseFirestore.instance;
    firestore.collection("message").snapshots().listen((event) {
      event.docChanges.forEach((res) {
        print(res.doc.id);
        if (res.type == DocumentChangeType.added) {
          if ((res.doc.data())['read']) {
            if (!readMessages.contains(res.doc.id)) {
              setState(() {
                readMessages.add(res.doc.id);
              });
            }
          } else {
            if (readMessages.contains(res.doc.id)) {
              setState(() {
                readMessages.remove(res.doc.id);
              });
            }
          }
        } else if (res.type == DocumentChangeType.modified) {
          if ((res.doc.data())['read']) {
            if (!readMessages.contains(res.doc.id)) {
              setState(() {
                readMessages.add(res.doc.id);
              });
            }
          } else {
            if (readMessages.contains(res.doc.id)) {
              setState(() {
                readMessages.remove(res.doc.id);
              });
            }
          }
        } else if (res.type == DocumentChangeType.removed) {
          setState(() {
            readMessages.remove(res.doc.id);
          });
        }
      });
    });
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message");
  }
}
