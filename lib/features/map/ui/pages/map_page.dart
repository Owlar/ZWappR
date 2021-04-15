import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zwappr/features/map/models/thing_marker_model.dart';
import 'package:zwappr/features/map/services/i_map_service.dart';
import 'package:zwappr/features/map/services/map_service.dart';
import 'package:zwappr/features/map/utils/list_category_icons.dart';
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
  static const _animationZoomLevel = 17.0;
  static const _stopClusteringZoomLevel = 14.0;
  static const _CATEGORY = "Kategori: ";

  Completer<GoogleMapController> _controller = Completer();

  ClusterManager _clusterManager;
  Set<Marker> markers = Set();
  List<ClusterItem<ThingMarker>> items = List();

  // Set to HiØ's position as default
  LatLng _currentPosition = LatLng(59.1292475, 11.3506146);

  // Markers with these categories will not be shown on map
  final Set<String> _categoriesFilteredAway = Set();

  MapType _currentMapType;
  bool flag = false;


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
    _getThingsFromServiceAndCreateMarkers();
    _clusterManager = _initClusterManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            body: GoogleMap(
              markers: markers,
              mapType: _currentMapType,
              initialCameraPosition: CameraPosition(
                  target: _currentPosition,
                  zoom: _initialZoomLevel
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                _clusterManager.setMapController(controller);
              },
              onCameraMove: _clusterManager.onCameraMove,
              onCameraIdle: flag == true ? _clusterManager.getMarkers : _clusterManager.updateMap,
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: false,
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  _openFilteringModalBottomSheet(context);
                },
                backgroundColor: zwapprYellow,
                icon: Icon(Icons.filter_list, color: zwapprBlack, size: 30),
                label: Text("Filtrere", style: TextStyle(color: zwapprBlack, fontSize: 16))
            )
        ),
        Padding(
          padding: EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 100),
              Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(),
                  mini: true,
                  onPressed: () {
                    _getCurrentPositionAndAnimate();
                  },
                  backgroundColor: zwapprWhite,
                  child: Icon(Icons.my_location, size: 30, color: zwapprBlack),
                )
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Visibility(
                    child: PopupMenuButton<TypeOfMap>(
                        child: FloatingActionButton(
                          // DON'T ADD onPressed
                          shape: RoundedRectangleBorder(),
                          mini: true,
                          backgroundColor: zwapprWhite,
                          child: Icon(Icons.layers, size: 30, color: zwapprBlack),
                        ),
                        onSelected: (TypeOfMap result) async {
                          switch(result) {
                            case TypeOfMap.Normal:
                              setState(() {
                                _currentMapType = MapType.normal;
                              });
                              break;
                            case TypeOfMap.Satellite:
                              setState(() {
                                _currentMapType = MapType.satellite;
                              });
                              break;
                            case TypeOfMap.Terrain:
                              setState(() {
                                _currentMapType = MapType.terrain;
                              });
                              break;
                            case TypeOfMap.Hybrid:
                              setState(() {
                                _currentMapType = MapType.hybrid;
                              });
                              break;
                            default:
                              _currentMapType = MapType.normal;
                          }
                        },
                        itemBuilder: (BuildContext buildContext) => <PopupMenuEntry<TypeOfMap>>[
                          const PopupMenuItem<TypeOfMap>(
                            value: TypeOfMap.Normal,
                            child: Text("Normal"),
                          ),
                          const PopupMenuItem<TypeOfMap>(
                            value: TypeOfMap.Satellite,
                            child: Text("Satellite"),
                          ),
                          const PopupMenuItem<TypeOfMap>(
                            value: TypeOfMap.Terrain,
                            child: Text("Terrain"),
                          ),
                          const PopupMenuItem<TypeOfMap>(
                            value: TypeOfMap.Hybrid,
                            child: Text("Hybrid"),
                          ),
                        ]
                    ),
                  )
              )
            ],
          )
        )
      ],
    );
  }

  void _getCurrentPositionAndAnimate() async {
    final GoogleMapController controller = await _controller.future;
    final geoPosition = await getUserGeoPosition();
    setState(() {
      _currentPosition = LatLng(geoPosition.latitude, geoPosition.longitude);
    });
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: _currentPosition,
        zoom: _animationZoomLevel,
      )
    ));
  }

  _onInfoWindowTapped(context, ThingMarker _infoWindowOwner) {
    showModalBottomSheet(context: context, builder: (BuildContext buildContext) {
      return Container(
          height: 300,
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
                          Navigator.of(context).pop();
                        },
                        child: Text("Tilbake", style: TextStyle(fontSize: 20))
                    ),
                  ],
                ),
                Container(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: _infoWindowOwner.imageUrl == null
                                ? Image.asset("assets/images/thing_image_placeholder.png")
                                : Image.network(_infoWindowOwner.imageUrl),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                              flex: 4,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text(_infoWindowOwner.title == null ? "" : _infoWindowOwner.title,
                                        style: TextStyle(
                                            fontSize: 26, fontWeight: FontWeight.bold
                                        ),
                                        overflow: TextOverflow.ellipsis
                                    ),
                                    SizedBox(height: 4),
                                    Text(_infoWindowOwner.description == null ? "" : _infoWindowOwner.description,
                                        style: TextStyle(fontSize: 18),
                                        overflow: TextOverflow.ellipsis
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                        _infoWindowOwner.exchangeValue == null
                                            ? ""
                                            : _infoWindowOwner.exchangeValue + " kr",
                                        style: TextStyle(
                                            fontSize: 20, fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                        _infoWindowOwner.condition == null
                                            ? ""
                                            : "Brukstilstand: " + _infoWindowOwner.condition,
                                        style: TextStyle(fontSize: 18),
                                        overflow: TextOverflow.ellipsis
                                    ),
                                    Text(
                                      _infoWindowOwner.category == null
                                          ? ""
                                          : "Kategori: " + _infoWindowOwner.category,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ])
                          ),
                          Expanded(
                              flex: 1,
                              child: Column(
                                  children: [
                                    Icon(Icons.favorite, size: 30, color: zwapprRed),
                                    SizedBox(height: 100),
                                  ]
                              )
                          )
                      ]
                    )

                )
              ]
          )
      );
    });
  }

  void _filterMarkersByCategory() async {
    flag = true;
    setState(() {
      _categoriesFilteredAway.forEach((c) => {
        markers.removeWhere((m) => m.infoWindow.snippet == "$_CATEGORY$c")
      });
    });
  }

  void _openFilteringModalBottomSheet(context) {
    showModalBottomSheet(context: context, builder: (BuildContext buildContext) {
      return StatefulBuilder(builder: (BuildContext context, StateSetter newStateForAllCards) {
        return Container(
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
                            Navigator.of(context).pop();
                          },
                          child: Text("Tilbake", style: TextStyle(fontSize: 20))
                      ),
                      TextButton(
                          onPressed: () {
                            _filterMarkersByCategory();
                            Navigator.of(context).pop();
                          },
                          child: Text("Filtrer", style: TextStyle(fontSize: 20))
                      ),
                      TextButton(
                          onPressed: () {
                            newStateForAllCards((){
                              _categoriesFilteredAway.removeAll(categories);
                            });
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
                            return StatefulBuilder(builder: (BuildContext context, StateSetter newStateForCard) {
                              final selectedCategory = categories[index];
                              return buildCategoryCard(selectedCategory, context, newStateForCard, index);
                            });
                          }
                      )
                  )
                ]
            )
        );
      });
    });
  }

  Card buildCategoryCard(String selectedCategory, BuildContext context, StateSetter stateSetter, int index) {
    return Card(
        margin: EdgeInsets.fromLTRB(70.0, 14.0, 70.0, 0),
        child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Checkbox(
                    value: !_categoriesFilteredAway.contains(selectedCategory),
                    onChanged: (value) {
                      stateSetter(() {
                        if (value == true) {
                          _categoriesFilteredAway.remove(selectedCategory);
                        } else {
                          _categoriesFilteredAway.add(selectedCategory);
                        }
                      });
                    },
                  ),
                  //Icon
                  categoryIcons[index],
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(selectedCategory),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      // TODO: Implement
                    },
                  )
                ]
            )
        )
    );
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
  Future<Marker> Function(Cluster<ThingMarker>) get _markerBuilder => (cluster) async {
    return Marker(
      markerId: MarkerId(cluster.getId()),
      position: cluster.location,
      infoWindow: InfoWindow(
          title: cluster.items.last.title,
          snippet: "$_CATEGORY${cluster.items.last.category}",
          onTap: () {
            _onInfoWindowTapped(context, cluster.items.last);
          }
      ),
      onTap: () {
          cluster.items.forEach((p) => print(p.title));
      },
      icon: await _getMarkerBitmap(cluster.isMultiple
          ? 125 : 75, text: cluster.isMultiple
          ? cluster.count.toString() : null),
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

enum TypeOfMap { Normal, Satellite, Terrain, Hybrid }