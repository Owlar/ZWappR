import 'package:flutter/foundation.dart';

class ThingModel {
  String uid;
  final String title;
  final String description;
  final String imageUrl;
  final String exchangeValue;
  final String condition;
  final String category;
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
    @required this.category,
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
        exchangeValue: json["exchangeValue"] as String,
        condition: json["condition"] as String,
        category: json["category"] as String
    );
  }
}