// import 'package:medfinderflutter/custom_local_notification.dart';
// import 'package:medfinderflutter/main.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
//
// class CustomFirebaseMessaging {
//   final CustomLocalNotification _customLocalNotification;
//
//   CustomFirebaseMessaging._internal(this._customLocalNotification);
//   static final CustomFirebaseMessaging _singleton =
//   CustomFirebaseMessaging._internal(CustomLocalNotification());
//   factory CustomFirebaseMessaging() => _singleton;
//
//   Future<void> Inicialize() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(badge: true, sound: true);
//
//     FirebaseMessaging.onMessage.listen((message) {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//
//       if (notification != null && android != null) {
//         _customLocalNotification.androidNotification(notification, android);
//       }
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       navigatorKey.currentState?.pushNamed(message.data['goTO']);
//     });
//   }
//
//   getTokenFirebase() async =>
//       debugPrint(await FirebaseMessaging.instance.getToken());
// }
//
