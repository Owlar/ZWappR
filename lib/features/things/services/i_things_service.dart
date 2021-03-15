import 'package:zwappr/features/things/models/thing_model.dart';

abstract class IThingsService {

  // Creating a thing with:
  /// [thing]
  Future<void> create(ThingModel thing);

  // Listing all things
  Future<List<ThingModel>> getAll();

  // Updating a thing with:
  /// [thing]
  Future<void> put(ThingModel thing);

  // Deleting a thing with:
  /// [uid]
  Future<void> delete(String uid);

  // Getting a thing with:
  /// [uid]
  Future<ThingModel> get(String uid);

}