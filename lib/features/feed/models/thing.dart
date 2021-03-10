import 'package:flutter/foundation.dart';

class Thing {
  final String uid;
  final String title;
  final String description;
  final int numberOfLikes;
  String imageUrl;
  bool isSwipedOff;
  bool isLiked;

  Thing({
    @required this.uid,
    @required this.title,
    @required this.description,
    @required this.numberOfLikes,
    this.imageUrl,
    this.isSwipedOff,
    this.isLiked
  });
}