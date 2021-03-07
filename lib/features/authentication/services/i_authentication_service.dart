import 'package:firebase_auth/firebase_auth.dart';
import 'package:zwappr/features/authentication/models/user_model.dart';

abstract class IAuthenticationService {

  // Signing out a user
  Future<void> signOut();

  // Signing in a user with:
  /// [email]
  /// [password]
  Future<UserModel> signIn({String email, String password});

  // Registering a user with:
  /// [displayName]
  /// [email]
  /// [password]
  Future<UserModel> register({String displayName, String email, String password});

  // Setting user in Firestore with:
  /// [user]
  /// [displayName]
  Future<void> createUser(User user, String displayName);

  // Signing in through Facebook auth provider
  Future<UserCredential> signInWithFacebook();

  // Getting the currently logged in user with:
  /// [user]
  Future<UserModel> getLoggedInUser(User user);

}