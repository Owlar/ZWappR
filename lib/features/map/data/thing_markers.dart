import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zwappr/features/map/models/thing_marker_model.dart';

//TODO: Replace this with fetching from db after testing
final List<ClusterItem<ThingMarker>> dummyThingMarkers = [
  ClusterItem(
      LatLng(58.1292475, 11.3506146),
      item: ThingMarker(
          title: "Klokke Rolex",
          description: "Pent brukt Rolex Submariner",
          numberOfLikes: 8,
          imageUrl: "https://images.unsplash.com/photo-1611243705491-71487c2ed137?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
          latitude: null,
          longitude: null,
          category: '',
          exchangeValue: '',
          condition: ''
  )
  ),
  ClusterItem(
      LatLng(61.1292475, 11.3506146),
      item: ThingMarker(
          title: "Kaktus",
          description: "Søt kaktus",
          numberOfLikes: 2,
          imageUrl: "https://images.unsplash.com/photo-1551888419-7b7a520fe0ca?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
          latitude: null,
          longitude: null,
          category: '',
          exchangeValue: '',
          condition: ''
      )
  ),
  ClusterItem(
      LatLng(59.1292475, 12.3506146),
      item: ThingMarker(
          title: "Old School TV",
          description: "Oransje TV som er old school cool",
          numberOfLikes: 72,
          imageUrl: "https://images.unsplash.com/photo-1593078165899-c7d2ac0d6aea?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
          latitude: null,
          longitude: null,
          category: '',
          exchangeValue: '',
          condition: ''
      )
  ),
  ClusterItem(
      LatLng(57.1292475, 13.3506146),
      item: ThingMarker(
          title: "Diverse klær",
          description: "Diverse klær selges pga. oppgradering av garderoben. Kom med bud!",
          numberOfLikes: 32,
          imageUrl: "https://images.unsplash.com/photo-1495121605193-b116b5b9c5fe?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=634&q=80",
          latitude: null,
          longitude: null,
          category: '',
          exchangeValue: '',
          condition: ''
      )
  ),
  ClusterItem(
      LatLng(59.0, 11.0),
      item: ThingMarker(
          title: "Klokke Rolex",
          description: "Pent brukt Rolex Submariner",
          numberOfLikes: 8,
          imageUrl: "https://images.unsplash.com/photo-1611243705491-71487c2ed137?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
          latitude: null,
          longitude: null,
          category: '',
          exchangeValue: '',
          condition: ''
      )
  ),
  ClusterItem(
      LatLng(59.1, 11.1),
      item: ThingMarker(
          title: "Kaktus",
          description: "Søt kaktus",
          numberOfLikes: 2,
          imageUrl: "https://images.unsplash.com/photo-1551888419-7b7a520fe0ca?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
          latitude: null,
          longitude: null,
          category: '',
          exchangeValue: '',
          condition: ''
      )
  ),
  ClusterItem(
      LatLng(58.9, 11.1),
      item: ThingMarker(
          title: "Old School TV",
          description: "Oransje TV som er old school cool",
          numberOfLikes: 72,
          imageUrl: "https://images.unsplash.com/photo-1593078165899-c7d2ac0d6aea?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
          latitude: null,
          longitude: null,
          category: '',
          exchangeValue: '',
          condition: ''
      )
  ),
  ClusterItem(
      LatLng(58.9, 11.2),
      item: ThingMarker(
          title: "Diverse klær",
          description: "Diverse klær selges pga. oppgradering av garderoben. Kom med bud!",
          numberOfLikes: 32,
          imageUrl: "https://images.unsplash.com/photo-1495121605193-b116b5b9c5fe?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=634&q=80",
          latitude: null,
          longitude: null,
          category: '',
          exchangeValue: '',
          condition: ''
      )
  ),
];