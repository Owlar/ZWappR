import 'package:zwappr/features/things/models/thing_model.dart';

abstract class ILikeService {

  Future<List<ThingModel>> getAll();

  // Creating a favorite with:
  /// [userId]
  Future<void> create(String userId);

  // Getting all liked things
  Future<Map> get();

}