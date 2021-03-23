import 'package:geolocator/geolocator.dart';

// Used in both things and map
Future<Position> getUserGeoPosition() async {
  final geoPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);
  return geoPosition;
}