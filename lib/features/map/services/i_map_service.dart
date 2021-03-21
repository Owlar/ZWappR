import 'package:zwappr/features/map/models/thing_marker_model.dart';

abstract class IMapService {
  // Listing all things
  Future<List<ThingMarker>> getAll();
}