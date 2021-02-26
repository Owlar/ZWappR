import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.press,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black),
        ),
      ),
      child: Row(
        children: [
          FlatButton(
            child: new Icon(
              icon,
              size: 36,
              color: Colors.black,
            ),
            onPressed: press,
          ),
          Text(text),
        ],
      ),
    );
  }
}