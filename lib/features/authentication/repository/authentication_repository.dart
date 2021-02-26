import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> setUser(User user, String displayName) async {
    final reference = _db.collection("users").doc(user.uid);
    await reference.set({
      "uid": user.uid,
      "email": user.email,
      "displayName": displayName,
    });
  }


}