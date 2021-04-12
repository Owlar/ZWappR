import 'package:zwappr/features/authentication/models/user_model.dart';
import 'package:zwappr/features/things/models/thing_model.dart';

abstract class ILikeService {

  // Updating me as a user with:
  /// [uid]
  Future<List<ThingModel>> getAll();

}