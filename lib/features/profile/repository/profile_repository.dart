import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:zwappr/features/authentication/models/user_model.dart';


class ProfileRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  Future<UserModel> get() async {
    final response = await http.get(
      "https://us-central1-zwappr.cloudfunctions.net/api/users/me",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "idToken": await _firebaseAuth.currentUser.getIdToken(true)
      },
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body)["data"]);
    } else {
      throw Exception('Failed to fetch data');
    }
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

}