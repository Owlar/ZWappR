import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:zwappr/features/map/models/thing_marker_model.dart';

class MapRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<List<ThingMarker>> getAll() async {
    final response = await http.get(
        "https://us-central1-zwappr.cloudfunctions.net/api/things/map",
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "idToken": await _firebaseAuth.currentUser.getIdToken()
        }
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> parsed = jsonDecode(response.body);
      return List<ThingMarker>.from(parsed["data"].map((x) => ThingMarker.fromJson(x)));
    } else {
      print("Statuscode is " + response.statusCode.toString());
      throw Exception("Failed to fetch data");
    }
  }


}