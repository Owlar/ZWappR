import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:zwappr/features/authentication/models/user_model.dart';
import 'package:zwappr/features/authentication/services/i_authentication_service.dart';

class AuthenticationService implements IAuthenticationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<UserModel> signIn({String email, String password}) async {
    try {
      final user = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
      return UserModel(user.uid, user.displayName);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }

  @override
  Future<UserModel> register({String displayName, String email, String password}) async {
    try {
      final user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
      await setUser(user, displayName);
      return UserModel(user.uid, user.displayName);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }

  @override
  Future<void> setUser(User user, String displayName) async {
    final reference = _db.collection("users").doc(user.uid);
    await reference.set({
      "uid": user.uid,
      "email": user.email,
      "displayName": displayName,
    });
  }

  @override
  Future<UserCredential> signInWithFacebook() async {
    final AccessToken result = await FacebookAuth.instance.login();
    final FacebookAuthCredential credential = FacebookAuthProvider.credential(result.token);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<UserModel> getLoggedInUser(User user) async {
    return user != null ? UserModel(user.uid, user.displayName) : null;
  }



}