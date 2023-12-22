// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables


import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_letter/firebase_options.dart';
import 'package:job_letter/routes.dart';
import 'package:job_letter/utils/color.dart';
import 'package:quick_notify/quick_notify.dart';

final box = GetStorage();
const projectId = "joblatter-36cbb";
var fcmToken;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

AndroidNotificationChannel? channel;

FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
late FirebaseMessaging messaging;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void notificationTapBackground(NotificationResponse notificationResponse) {
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    debugPrint(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Firestore.initialize(projectId);

  await QuickNotify.hasPermission();
  await QuickNotify.requestPermission();

if(Platform.isAndroid)
  {
    messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
     fcmToken = await messaging.getToken();
    print("---->> token : $fcmToken");

    await messaging.subscribeToTopic('flutter_notification');
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
          'flutter_notification', // id
          'flutter_notification_title', // title
          importance: Importance.high,
          enableLights: true,
          enableVibration: true,
          showBadge: true,
          playSound: true);

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      final android = AndroidInitializationSettings('@drawable/icon');
      final iOS = DarwinInitializationSettings();
      final initSettings = InitializationSettings(android: android, iOS: iOS);

      await flutterLocalNotificationsPlugin!.initialize(initSettings,
          onDidReceiveNotificationResponse: notificationTapBackground,
          onDidReceiveBackgroundNotificationResponse: notificationTapBackground);

      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          theme:
              ThemeData(appBarTheme: AppBarTheme(color: ColorTheme.lightblue)),
          useInheritedMediaQuery: true,
          // navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          getPages: AppPages.routes,
          initialRoute: AppPages.splash,
        );
      },
    ),
  );
}
