import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

class Button extends StatelessWidget {
  final VoidCallback press;

  const Button({
    Key key,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB( 125, 0,  125, 30),
      child: ButtonTheme(
        height: 10,
        minWidth: 100,
        child: FlatButton(
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
               ),
            color: zwapprLightGray,
            onPressed: press,
            child: Row(
              children: [Expanded(child: Text("Inviter",
                textAlign: TextAlign.center,))],
            )),
      ),
    );
  }
}