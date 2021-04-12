import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:zwappr/features/authentication/models/user_model.dart';
import 'package:zwappr/features/things/models/thing_model.dart';


class LikeRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  Future<List<ThingModel>> getAll() async {
    final response = await http.get(
        "https://us-central1-zwappr.cloudfunctions.net/api/things/favorite",
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "idToken": await _firebaseAuth.currentUser.getIdToken()
        }
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> parsed = jsonDecode(response.body);
      return List<ThingModel>.from(
          parsed["data"].map((x) => ThingModel.fromJson(x)));
    } else {
      print("Statuscode is " + response.statusCode.toString());
      throw Exception("Failed to fetch data");
    }
  }
}