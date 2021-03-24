import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwappr/features/home/service/i_notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService implements INoticationService  {

  FirebaseMessaging messaging = FirebaseMessaging();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();



  @override
  Future<void> setupNotification() async {
    print("Configuring notification");

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);


    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        channel.id, channel.name, channel.description,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        icon: '@mipmap/ic_launcher',
    );

    NotificationDetails platformChannelSpecifics  = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    print("Configuring messaging");
    messaging.configure(
      onMessage: (Map<String, dynamic> response) async {
        print("onMessage: $response");
        print("MESSAGE");


        flutterLocalNotificationsPlugin.show(
            0,
            response["notification"]["title"],
            response["notification"]["body"],
            platformChannelSpecifics,
            );



      },
    );
    print("Configuration complete!");
  }
}