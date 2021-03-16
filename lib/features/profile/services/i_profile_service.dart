import 'package:zwappr/features/authentication/models/user_model.dart';

abstract class IProfileService {

  // Updating me as a user with:
  /// [uid]
  Future<void> put(String uid);
  Future<void> updateImage(String url);
  // Getting me as a user with:
  /// [uid]
  Future<UserModel> get();

}