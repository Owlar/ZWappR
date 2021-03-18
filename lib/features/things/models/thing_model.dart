import 'package:flutter/foundation.dart';
import 'package:zwappr/features/things/utils/list_conditions.dart';

import 'tag_model.dart';

class ThingModel {
  String uid;
  final String title;
  final String description;
  final String imageUrl;
  final double exchangeValue;
  final String condition;
  final List<Category> categories;
  int numberOfLikes;
  bool isSwipedOff;
  bool isLiked;

  ThingModel({
    this.uid,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.exchangeValue,
    @required this.condition,
    @required this.categories,
    this.numberOfLikes,
    this.isSwipedOff,
    this.isLiked
  });

  factory ThingModel.fromJson(Map<String, dynamic> json) {
    return ThingModel(
        uid: json["uid"] as String,
        title: json["title"] as String,
        description: json["description"] as String,
        imageUrl: json["imageUrl"] as String,
        exchangeValue: json["exchangeValue"] as double,
        condition: json["condition"] as String,
        categories: json["categories"] as List<Category>
    );
  }
}