import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  String _currentPositionLatitude;
  String _currentPositionLongitude;
  // Set to HiØ as default
  LatLng _currentPosition = LatLng(59.1292475, 11.3506146);

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _currentPosition,
            zoom: 10
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: _filter,
            icon: Icon(Icons.filter_list),
            label: Text("Filter")
        )

    );
  }

  Future<void> _filter() async {
    // TODO: Filtering on things
    print(_currentPositionLatitude);
    print(_currentPositionLongitude);
  }

  void _getCurrentPosition() async {
    final geoPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    setState(() {
      _currentPositionLatitude = "${geoPosition.latitude}";
      _currentPositionLongitude = "${geoPosition.longitude}";
      _currentPosition = LatLng(geoPosition.latitude, geoPosition.longitude);
    });
  }

  void _goToMyLocation() {

  }


}