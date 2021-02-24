import 'package:firebase_auth/firebase_auth.dart';
import 'package:zwappr/features/authentication/models/user_model.dart';

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
  Future<String> register({String email, String password, String username});

  // Signing in through Facebook auth provider
  Future<UserCredential> signInWithFacebook();

  // Getting the currently logged in user with:
  /// [user]
  Future<UserModel> getLoggedInUser(User user);

}