import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class AuthenticationRepository {

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