import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:zwappr/features/things/models/thing_model.dart';
import 'package:http/http.dart' as http;

class ThingsRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> createThing(ThingModel thing) async {
    var apiCall = await http.post(
      "https://us-central1-zwappr.cloudfunctions.net/api/things",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "idToken": await _firebaseAuth.currentUser.getIdToken()
      },
      body: jsonEncode(<String, String>{
        "title": thing.title,
        "description": thing.description
      }),
    );
  }

}