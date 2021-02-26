
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconButtons extends StatelessWidget {
  const IconButtons({
    Key key,
    @required this.icon,
    @required this.press,
  }) : super(key: key);
  final IconData icon;
  final  VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20, vertical: 0),
      child: SizedBox(
        height: 46,
        width: 46,
        child: IconButton(
            icon: Icon(icon),
            iconSize: 36,
            color: Colors.black,
            onPressed: press
        ),
      ),
    );
  }
}
