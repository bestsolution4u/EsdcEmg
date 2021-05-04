import 'package:esdc_emg/app.dart';
import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/util/bloc_inspector.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFCM();
  Bloc.observer = BlocInspector();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((value) => runApp(EsdcEmgApp()));
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
  });
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}