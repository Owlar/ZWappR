import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class FavoriteRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> create(String thingId) async {
    await http.post(
      "https://us-central1-zwappr.cloudfunctions.net/api/things/favorite",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "idToken": await _firebaseAuth.currentUser.getIdToken(true)
      },
      body: jsonEncode(<String, String>{
        "item": thingId,
      }),
    );
  }
}
