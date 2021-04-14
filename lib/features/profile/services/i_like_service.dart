import 'package:zwappr/features/authentication/models/user_model.dart';
import 'package:zwappr/features/things/models/thing_model.dart';

abstract class ILikeService {


  Future<List<ThingModel>> getAll();
  // Creating a favorite with:
  /// [userId]
  Future<void> create(String userId);
  // get all liked things
  Future<Map> get();

}