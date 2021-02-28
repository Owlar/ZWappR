import 'package:flutter/foundation.dart';

class Thing {
  final String uid;
  final String title;
  final String description;
  final int numberOfLikes;
  final bool isSwipedOff;
  final bool isLiked;

  Thing({
    @required this.uid,
    @required this.title,
    @required this.description,
    @required this.numberOfLikes,
    @required this.isSwipedOff,
    @required this.isLiked
  });
}