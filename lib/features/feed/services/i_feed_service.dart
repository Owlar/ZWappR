import 'package:zwappr/features/things/models/thing_model.dart';

abstract class IFeedService {

  // Getting all things in feed for user with:
  Future<List<ThingModel>> getAll() async => getAll();

  // Getting all of my own things in feed with:
  Future<List<ThingModel>> getAllOfMyOwn() async => getAllOfMyOwn();

  // Deleting a thing with:
  /// [uid]
  Future<void> delete(String uid);

}