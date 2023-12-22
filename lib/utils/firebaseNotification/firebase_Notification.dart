// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
//
//
// Future<void> handleMessage(RemoteMessage msg) async
// {
//   debugPrint("title : ${msg.notification?.title}");
// }
//
// class notifyFirebase {
//   static final firebase = FirebaseMessaging.instance;
//
//   static Future initNotification() async
//   {
//     await firebase.requestPermission().then((value) =>
//         debugPrint("-------->> req : $value"));
//     await firebase.getToken().then((value) =>
//         debugPrint("-------->> token : $value"));
//
//     FirebaseMessaging.onBackgroundMessage(handleMessage);
//   }
//
// }