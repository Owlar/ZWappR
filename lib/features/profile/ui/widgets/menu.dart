import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

class Menu extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback press;

  const Menu({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: zwapprBlack),
        ),
      ),
      child: Row(
        children: [
          TextButton(
            child: new Icon(
              icon,
              size: 36,
              color: zwapprBlack,
            ),
            onPressed: press,
          ),
          Text(text),
        ],
      ),
    );
  }
}