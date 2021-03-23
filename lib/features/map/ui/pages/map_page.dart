import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zwappr/features/map/models/thing_marker_model.dart';
import 'package:zwappr/features/map/services/i_map_service.dart';
import 'package:zwappr/features/map/services/map_service.dart';
import 'package:zwappr/features/map/ui/widgets/category_card.dart';
import 'package:zwappr/features/things/utils/list_categories.dart';
import 'package:zwappr/utils/colors/color_theme.dart';
import 'package:zwappr/utils/location/user_geo_position.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static final IMapService _mapService = MapService();
  static const _initialZoomLevel = 6.0;
  static const _stopClusteringZoomLevel = 14.0;

  Completer<GoogleMapController> _controller = Completer();

  ClusterManager _clusterManager;
  Set<Marker> markers = Set();
  List<ClusterItem<ThingMarker>> items = List();

  String _currentPositionLatitude;
  String _currentPositionLongitude;

  // Set to HiØ's position as default
  LatLng _currentPosition = LatLng(59.1292475, 11.3506146);

  Future<void> _getThingsFromServiceAndCreateMarkers() async {
    final List<ThingMarker> _thingsAsMarkersFromService = (await _mapService.getAll());
    _thingsAsMarkersFromService.forEach((thing) => {
      items.add(
          ClusterItem(
              LatLng(thing.latitude, thing.longitude),
              item: thing
          )
      )
    });
  }

  @override
  void initState() {
    _getCurrentPosition();
    _getThingsFromServiceAndCreateMarkers();
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
            onPressed: () {
              _openFilteringModalBottomSheet(context);
            },
            icon: Icon(Icons.filter_list, color: zwapprBlack, size: 30),
            label: Text("Filter", style: TextStyle(color: zwapprBlack, fontSize: 16))
        )

    );
  }

  void _openFilteringModalBottomSheet(context) {
    showModalBottomSheet(context: context, builder: (BuildContext buildContext) {
      return Scaffold(
          body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background_screen.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {

                          },
                          child: Text("Tilbake", style: TextStyle(fontSize: 20))
                      ),
                      Text("Kategori", style: TextStyle(fontSize: 20)),
                      TextButton(
                        onPressed: () {

                        },
                        child: Text("Nullstill", style: TextStyle(fontSize: 20))
                      )
                    ],
                  ),
                  Container(
                      height: 300,
                      child: ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (BuildContext context, int index) {
                            final selectedCategory = categories[index];
                            return buildCategoryCard(selectedCategory, context);
                          }
                      )
                  )
                ]
              )
          )
      );
    });
  }

  void _getCurrentPosition() async {
    final geoPosition = await getUserGeoPosition();
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
    final Paint paint1 = Paint()..color = zwapprBlue;
    final Paint paint2 = Paint()..color = zwapprGreen;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: zwapprBlack,
            fontWeight: FontWeight.bold),
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