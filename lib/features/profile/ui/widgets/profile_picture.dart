import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePicture extends StatelessWidget {
  final File _image;
  final String uri;
  final  VoidCallback press;



  const ProfilePicture({
    Key key,
    @required File image,
    @required  this.press,
    this.uri,

  }) : _image = image, super(key: key);

  @override
  Widget build(BuildContext context) {
    String pic = uri+"?type=large";
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: SizedBox(
        height: 115,
        width: 115,
        child: Stack(
          fit: StackFit.expand,
          overflow: Overflow.visible,
          children: [
            CircleAvatar(
              backgroundImage: _image == null ? NetworkImage(pic) : FileImage(_image),
            ),
            Positioned(
              right: -12,
              bottom: 0,
              child: SizedBox(
                  height: 46,
                  width: 46,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Color(0xFFFFFF))),
                    color: Color(0xFFE0E0E0),
                    onPressed:press,//photoPicker,
                    child: SvgPicture.asset("assets/icons/photo_camera-24px.svg"),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}