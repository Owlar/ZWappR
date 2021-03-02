import 'package:flutter/material.dart';

enum SwipingDirection {left, right, none}

class FeedbackPositionProvider extends ChangeNotifier {
  double _dx = 0.0;
  SwipingDirection _swipingDirection;
  SwipingDirection get swipingDirection => _swipingDirection;

  FeedbackPositionProvider() {
    _swipingDirection = SwipingDirection.none;
  }

  void resetPosition() {
    _dx = 0.0;
    _swipingDirection = SwipingDirection.none;
    notifyListeners();
  }

  void updatePosition(double changeInDirectionX) {
    _dx = _dx + changeInDirectionX;

    if (_dx > 0) _swipingDirection = SwipingDirection.right;
    else if (_dx < 0) _swipingDirection = SwipingDirection.left;
    else _swipingDirection = SwipingDirection.none;

    notifyListeners();
  }

  // Source: https://github.com/Owlar/tinder_ui_clone_example/blob/master/lib/provider/feedback_position_provider.dart
}