import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:zwappr/features/things/models/thing_model.dart';
import 'package:http/http.dart' as http;

class ThingsRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> create(ThingModel thing) async {
    await http.post(
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

  Future<List<ThingModel>> getAll() async {
    final response = await http.get(
      "https://us-central1-zwappr.cloudfunctions.net/api/things",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "idToken": await _firebaseAuth.currentUser.getIdToken()
      }
    );
    //return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
    final Map<String, dynamic> parsed = jsonDecode(response.body);
    return List<ThingModel>.from(parsed["data"].map((x) => ThingModel.fromJson(x)));
  }

  put(String uid) async {
    await http.put(
      "https://us-central1-zwappr.cloudfunctions.net/api/things/$uid",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "idToken": await _firebaseAuth.currentUser.getIdToken()
      },
      body: jsonEncode(<String, String>{
        "title": "123TEST",
        "description": "123TEST"
      }),
    );
  }

  delete(String uid) async {
    await http.delete(
      "https://us-central1-zwappr.cloudfunctions.net/api/things/$uid",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "idToken": await _firebaseAuth.currentUser.getIdToken()
      },
    );
  }

  get(String uid) async {
    await http.get(
      "https://us-central1-zwappr.cloudfunctions.net/api/things/$uid",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "idToken": await _firebaseAuth.currentUser.getIdToken()
      },
    );
  }

}