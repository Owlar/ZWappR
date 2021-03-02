import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class AuthenticationRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> setUser(User user, String displayName) async {
    final reference = _db.collection("users").doc(user.uid);
    await reference.set({
      "uid": user.uid,
      "email": user.email,
      "displayName": displayName,
    });
  }

  Future<void> createUser(User user, String displayName) async {

    var apiCall = await http.post(
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


}