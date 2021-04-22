import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:zwappr/features/things/models/thing_model.dart';

import 'repo_things.mocks.dart';


final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {

  group('fetchAlbum', () {
    test('returns an Data if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get("https://us-central1-zwappr.cloudfunctions.net/api/things/me"))
          .thenAnswer((_) async => http.Response('["userId": 1, "id": 2, "title": "mock"]', 200));

      expect(await getAll(client), isA<List<ThingModel>>());
    });

   /* test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get("https://us-central1-zwappr.cloudfunctions.net/api/things/me"))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(getAll(client), throwsException);
    });*/
  });
}
Future<List<ThingModel>> getAll(http.Client client) async {
  final response = await client.get(
      "https://us-central1-zwappr.cloudfunctions.net/api/things/me",
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