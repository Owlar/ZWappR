import 'package:zwappr/features/feed/models/category.dart';

class Thing {
  final String uid;
  final String title;
  final String description;
  final List<Category> categories;
  final int numberOfLikes;
  final bool isSwipedOff;
  final bool isLiked;

  Thing(
      this.uid,
      this.title, 
      this.description,
      this.categories,
      this.numberOfLikes,
      this.isSwipedOff,
      this.isLiked
      );
}