import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthenticationService {

  // Signing out a user
  Future<void> signOut();

  // Signing in a user with:
  /// [email]
  /// [password]
  Future<String> signIn({String email, String password});

  // Registering a user with:
  /// [email]
  /// [password]
  Future<String> register({String email, String password});

  // Signing in through Facebook auth provider
  Future<UserCredential> signInWithFacebook();

}