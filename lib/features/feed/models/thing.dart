import 'package:flutter/foundation.dart';

// TODO: Remove class
// Class will eventually be removed as things are created in feature 'things' and not 'feed'
// This means that class thing_model in models in feature 'things' will be used

class Thing {
  final String uid;
  final String title;
  final String description;
  int numberOfLikes;
  String imageUrl;
  bool isSwipedOff;
  bool isLiked;

  Thing({
    @required this.uid,
    @required this.title,
    @required this.description,
    this.numberOfLikes,
    this.imageUrl,
    this.isSwipedOff,
    this.isLiked
  });
}