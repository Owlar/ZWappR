import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:zwappr/features/feed/repository/feed_repository.dart';
import 'package:zwappr/features/feed/services/i_feed_service.dart';
import 'package:zwappr/features/things/models/thing_model.dart';


class FeedService implements IFeedService {
  final FeedRepository _feedRepository = FeedRepository();
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<List<ThingModel>> getAll() async => _feedRepository.getAll();

  @override
  Future<List<ThingModel>> getAllOfMyOwn() async => _feedRepository.getAllOfMyOwn();

  @override
  Future<void> delete(String uid) async => _feedRepository.delete(uid);

  @override
  Future<void> offerItemInExchangeForLikedItem(ThingModel thingOffer, String thingLikedUid) async {
    await http.post(
      "https://us-central1-zwappr.cloudfunctions.net/api/things/like/$thingLikedUid",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "idToken": await _firebaseAuth.currentUser.getIdToken()
      },
      body: jsonEncode(<String, String>{
        "offer": thingOffer.uid,
      }),
    );
  }

  @override
  Future<void> seenItem(String thingSeenUid) async {
    await http.post(
      "https://us-central1-zwappr.cloudfunctions.net/api/things/seen/$thingSeenUid",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "idToken": await _firebaseAuth.currentUser.getIdToken()
      },
      body: jsonEncode(<String, String>{
        "seen": thingSeenUid,
      }),
    );
  }
}