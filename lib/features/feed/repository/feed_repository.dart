import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zwappr/features/feed/models/thing.dart';
import 'package:zwappr/features/things/models/thing_model.dart';
import 'package:http/http.dart' as http;

class FeedRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  Future<List<ThingModel>> getAll() async {
    final response = await http.get(
        "https://us-central1-zwappr.cloudfunctions.net/api/things",
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "idToken": await _firebaseAuth.currentUser.getIdToken()
        }
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> parsed = jsonDecode(response.body);
      return List<ThingModel>.from(parsed["data"].map((x) => ThingModel.fromJson(x)));
    } else {
      print("Statuscode is " + response.statusCode.toString());
      throw Exception("Failed to fetch data");
    }
  }

}