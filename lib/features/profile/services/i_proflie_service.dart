import 'package:zwappr/features/authentication/models/user_model.dart';

abstract class IProfileService {

  // Creating a thing with:
  /// [thing]

  // Listing all things


  // Updating a thing with:
  /// [uid]
  Future<void> put(String uid);

  // Deleting a thing with:
  /// [uid]


  // Getting a thing with:
  /// [uid]
  Future<UserModel> get();

}