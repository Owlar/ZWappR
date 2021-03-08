import 'package:zwappr/features/things/models/thing_model.dart';
import 'package:zwappr/features/things/repository/things_repository.dart';

import 'i_things_service.dart';

class ThingsService implements IThingsService {
  final ThingsRepository _repository = ThingsRepository();

  @override
  Future<void> createThing(ThingModel thing) async => _repository.createThing(thing);

}