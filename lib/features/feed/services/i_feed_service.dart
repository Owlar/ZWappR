import 'package:zwappr/features/things/models/thing_model.dart';

abstract class IFeedService {

  // Getting all things in feed for user with:
  Future<List<ThingModel>> getAll() async => getAll();

}