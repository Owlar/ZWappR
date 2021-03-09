import 'package:flutter/material.dart';
import 'package:zwappr/features/home/service/i_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService implements INoticationService {

  FirebaseMessaging messaging = FirebaseMessaging();

  @override
  Future<void> setupNotification() {

    print("Configuring messaging");

    messaging.configure(
      onMessage: (Map<String, dynamic> response) async {
        print("onMessage: $response");

      },
    );

    print("Configuration complete!");

  }
}