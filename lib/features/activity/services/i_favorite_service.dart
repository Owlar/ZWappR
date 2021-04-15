import 'package:zwappr/features/things/models/thing_model.dart';

abstract class IFavoriteService {

  // Creating a favorite with:
  /// [userId]
  Future<void> create(String userId);

  // Updating my favorite with:
  /// [uid]
  Future<void> put(String uid);

  // Listing all favorites
  Future<List<ThingModel>> getAll();

  // Getting me as a user
  Future<Map> getMe();

  // delete favorite
  Future<void> delete(String thingId);

}