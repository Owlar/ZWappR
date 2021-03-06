import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class ChatRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Map> getMe() async {
    final response = await http.get(
      "https://us-central1-zwappr.cloudfunctions.net/api/api/users/me",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "idToken":  await _firebaseAuth.currentUser.getIdToken(true)
      },
    );
    return (jsonDecode(response.body));
  }

  Future<Map> get() async {
    final response = await http.get(
      "https://us-central1-zwappr.cloudfunctions.net/api/convo",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "idToken":  await _firebaseAuth.currentUser.getIdToken(true)
      },
    );
    return (jsonDecode(response.body));
  }

  Future<Map> getMsg(String uid) async {
    final response = await http.get(
      "https://us-central1-zwappr.cloudfunctions.net/api/convo/" + uid + "?p=0",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "idToken":  await _firebaseAuth.currentUser.getIdToken(true)
      },
    );
    return (jsonDecode(response.body));
  }

  Future<void> put(String name) async {
    await http.put(
      "https://us-central1-zwappr.cloudfunctions.net/api/users/me",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "idToken": await _firebaseAuth.currentUser.getIdToken(true)
      },
      body: jsonEncode(<String, String>{
        "displayName": name
      }),
    );
  }

  Future<void> create(String userId) async {
    await http.post(
      "https://us-central1-zwappr.cloudfunctions.net/api/convo",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "idToken": await _firebaseAuth.currentUser.getIdToken(true)
      },
      body: jsonEncode(<String, String>{
        "toUser": userId,
      }),
    );
  }

  Future<void> createMsg(String convoId, String msg) async {
    await http.post(
      "https://us-central1-zwappr.cloudfunctions.net/api/convo/"+ convoId,
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "idToken": await _firebaseAuth.currentUser.getIdToken(true)
      },
      body: jsonEncode(<String, String>{
        "content": msg,
      }),
    );
  }

}