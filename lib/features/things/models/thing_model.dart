import 'package:flutter/foundation.dart';

class ThingModel {
  final String uid;
  final String title;
  final String description;
  int numberOfLikes;
  String imageUrl;
  bool isSwipedOff;
  bool isLiked;

  ThingModel({
    @required this.uid,
    @required this.title,
    @required this.description,
    this.numberOfLikes,
    this.imageUrl,
    this.isSwipedOff,
    this.isLiked
  });

  factory ThingModel.fromJson(Map<String, dynamic> json) {
    return ThingModel(
        uid: json["uid"] as String,
        title: json["title"] as String,
        description: json["description"] as String,
    );
  }
}