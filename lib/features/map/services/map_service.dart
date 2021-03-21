import 'package:zwappr/features/map/models/thing_marker_model.dart';

import 'i_map_service.dart';
import 'package:zwappr/features/map/repository/map_repository.dart';

class MapService implements IMapService {
  MapRepository _repository = MapRepository();

  @override
  Future<List<ThingMarker>> getAll() async => _repository.getAll();

}