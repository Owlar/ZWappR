import 'package:zwappr/features/things/models/thing_model.dart';
import 'package:zwappr/features/things/repository/things_repository.dart';

import 'i_things_service.dart';

class ThingsService implements IThingsService {
  final ThingsRepository _repository = ThingsRepository();

  @override
  Future<void> create(ThingModel thing) async => _repository.create(thing);

  @override
  Future<List<ThingModel>> getAll() async => _repository.getAll();

  @override
  Future<void> put(String uid) async => _repository.put(uid);

  @override
  Future<void> delete(String uid) async => _repository.delete(uid);

  @override
  Future<ThingModel> get(String uid) async => _repository.get(uid);

}