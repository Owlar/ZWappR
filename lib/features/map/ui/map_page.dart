import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zwappr/features/feed/models/thing.dart';
import 'package:zwappr/features/map/models/thing_marker_model.dart';
import 'package:zwappr/features/map/services/i_map_service.dart';
import 'package:zwappr/features/map/services/map_service.dart';
import 'package:zwappr/features/map/data/thing_markers.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static final IMapService _mapService = MapService();
  static const _initialZoomLevel = 8.0;
  static const _stopClusteringZoomLevel = 15.0;

  Completer<GoogleMapController> _controller = Completer();

  ClusterManager _clusterManager;
  Set<Marker> markers = Set();
  List<ClusterItem<ThingMarker>> items = dummyThingMarkers;

  String _currentPositionLatitude;
  String _currentPositionLongitude;

  // Set to HiØ's position as default
  LatLng _currentPosition = LatLng(59.1292475, 11.3506146);

  // TODO: Do this instead of using dummy marker data
  /*Future<void> _getThingsFromServiceAndCreateMarkers() async {
    final List<ThingMarker> _thingsAsMarkersFromService = (await _mapService.getAll());
    _thingsAsMarkersFromService.forEach((thing) => {
      items.add(
          ClusterItem(
              LatLng(thing.latitude, thing.longitude),
              item: thing
          )
      )
    });
  }*/

  @override
  void initState() {
    _getCurrentPosition();
    //_getThingsFromServiceAndCreateMarkers();
    _clusterManager = _initClusterManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _currentPosition,
            zoom: _initialZoomLevel
          ),
          markers: markers,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            _clusterManager.setMapController(controller);
          },
          onCameraMove: _clusterManager.onCameraMove,
          onCameraIdle: _clusterManager.updateMap,
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


  }

  void _getCurrentPosition() async {
    final geoPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    setState(() {
      _currentPositionLatitude = "${geoPosition.latitude}";
      _currentPositionLongitude = "${geoPosition.longitude}";
      _currentPosition = LatLng(geoPosition.latitude, geoPosition.longitude);
    });
  }

  ClusterManager _initClusterManager() {
    return ClusterManager<ThingMarker>(
        items,
        _updateMarkers,
        markerBuilder: _markerBuilder,
        initialZoom: _initialZoomLevel,
        stopClusteringZoom: _stopClusteringZoomLevel
    );
  }

  void _updateMarkers(Set<Marker> markers) {
    setState(() {
      this.markers = markers;
    });
  }

  // Source (21.03.2021):
  // https://pub.dev/packages/google_maps_cluster_manager/versions/0.2.1/example
  Future<Marker> Function(Cluster<ThingMarker>) get _markerBuilder =>
          (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            print('---- $cluster');
            cluster.items.forEach((p) => print(p));
          },
          icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
              text: cluster.isMultiple ? cluster.count.toString() : null),
        );
      };

  // Source (21.03.2021):
  // https://pub.dev/packages/google_maps_cluster_manager/versions/0.2.1/example
  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String text}) async {
    assert(size != null);

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.orange;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }


}