import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:zwappr/features/authentication/services/i_authentication_service.dart';
import 'package:zwappr/features/authentication/models/user_model.dart';

class AuthenticationService implements IAuthenticationService {
  final FirebaseFirestore _db;
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth, this._db);
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  @override
  Future<String> register({String email, String password, String username}) async {
    try {
      final user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
      await _setUser(user);
      return "Registered";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> _setUser(User user) async {
    final reference = _db.collection("users").doc(user.uid);
    await reference.set({
      "uid": user.uid,
      "email": user.email,
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
    return user != null ? UserModel(user.uid) : null;
  }



}