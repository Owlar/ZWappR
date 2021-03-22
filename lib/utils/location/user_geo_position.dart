import 'package:geolocator/geolocator.dart';

// Used for both things and map
Future<Position> getUserGeoPosition() async {
  final geoPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);
  return geoPosition;
}