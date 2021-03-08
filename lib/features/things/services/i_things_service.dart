import 'package:zwappr/features/things/models/thing_model.dart';

abstract class IThingsService {

  // Creating a thing with:
  /// [thing]
  Future<void> createThing(ThingModel thing);

}