import 'package:flutter/foundation.dart';

class ThingModel {
  final String title;
  final String description;

  ThingModel({
    @required this.title,
    @required this.description
  });

  factory ThingModel.fromJson(Map<String, dynamic> json) {
    return ThingModel(
        title: json["title"] as String,
        description: json["description"] as String,
    );
  }
}