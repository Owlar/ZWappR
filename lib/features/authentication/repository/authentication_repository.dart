import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class AuthenticationRepository {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future<void> createUser(User user, String displayName) async {
    await http.post(
      "https://us-central1-zwappr.cloudfunctions.net/api/users/register",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(<String, String>{
        "displayName": displayName,
        "email": user.email,
        "uid": user.uid
      }),
    ); 
  }

  Future<void> updateToken() async {

    await http.put(
      "https://us-central1-zwappr.cloudfunctions.net/api/users/me",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "idToken": await _firebaseAuth.currentUser.getIdToken()
      },
      body: jsonEncode(<String, String>{
        "token": await _fcm.getToken(),
      }),
    );
  }

}