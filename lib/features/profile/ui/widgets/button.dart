import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                side: BorderSide(color: Color(0xFFFFFF))),
            color: Color(0xFFE0E0E0),
            onPressed: press,
            child: Row(
              children: [Expanded(child: Text("Inviter",
                textAlign: TextAlign.center,))],
            )),
      ),
    );
  }
}