import 'package:flutter/cupertino.dart';
import 'package:zwappr/features/map/models/thing_marker_model.dart';
import 'package:zwappr/features/map/services/i_map_service.dart';
import 'package:zwappr/features/map/services/map_service.dart';

class FetchDataProvider with ChangeNotifier {
  static final IMapService _mapService = MapService();
  List<ThingMarker> items = [];

  Future<void> getFetchedData() async {
    items = await _mapService.getAll();
    notifyListeners();
  }
}