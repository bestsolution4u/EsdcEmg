import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/screen/main/dashboard_screen.dart';
import 'package:esdc_emg/screen/main/employee_screen.dart';
import 'package:esdc_emg/screen/main/message_screen.dart';
import 'package:esdc_emg/screen/main/social_media_screen.dart';
import 'package:esdc_emg/widget/tabbar/esdc_tabbar.dart';
import 'package:esdc_emg/widget/tabbar/main_tab_item.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  FirebaseMessaging _fcmMessaging;
  final int tabLength = 4;
  TabController tabController;
  int currentTabIndex = 0;
  Stream<String> _tokenStream;
  @override
  void initState() {
    super.initState();
    registerNotification();
    tabController = TabController(
      initialIndex: 0,
      length: tabLength,
      vsync: this,
    )..addListener(handleTabController);
  }

  void registerNotification() async {
    await Firebase.initializeApp();
    _fcmMessaging = FirebaseMessaging.instance;
    await _fcmMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    _fcmMessaging.getToken().then((token) => print("FCM Token 1: " + token));
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen((token) => print("FCM Token 2: " + token));

    _fcmMessaging.getInitialMessage().then((RemoteMessage message) {
      if (message != null) {
        print("Initial Messages: " + message.messageId);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("----------------- onMessage ----------------");
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
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',

              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('===========A new onMessageOpenedApp event was published!');
      tabController.index = 2;
    });
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
              DashboardScreen(),
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
                MainTabItem(title: 'MyESDC', image: 'asset/image/star.svg', selected: currentTabIndex == 0,),
                MainTabItem(title: 'Messages', image: 'asset/image/mail.svg', selected: currentTabIndex == 1,),
                MainTabItem(title: 'Employees', image: 'asset/image/user.svg', selected: currentTabIndex == 2,),
                MainTabItem(title: 'Social media', image: 'asset/image/sound.svg', selected: currentTabIndex == 3,),
              ],
            ),
          ),
        )
    );
  }
}
