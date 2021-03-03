import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwappr/features/color/color_theme.dart';

class ChatInfoPerson extends StatelessWidget {
  final name;
  final image;

  const ChatInfoPerson({
    Key key,
    this.image,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(right: 16),
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: zwapprBlue,
                size: 26,
              ),
            ),
            SizedBox(
              width: 2,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(image),
              maxRadius: 20,
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
