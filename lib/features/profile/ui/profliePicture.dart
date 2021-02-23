



import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import 'profile_page.dart';

// ignore: must_be_immutable
class ProfilePicture extends StatelessWidget{
  File _image;
  final imagePicker = ImagePicker();

  Future getImage() async{
    final image = await imagePicker.getImage(source: ImageSource.camera);

     _image = File(image.path);

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            overflow: Overflow.visible,
            children: [
              CircleAvatar(
                backgroundImage: _image == null ? AssetImage("assets/images/profile_test.png") : FileImage(_image),
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
                    color: Color(0xFFC9C9C9),
                    onPressed: getImage,
                    child: SvgPicture.asset("assets/icons/photo_camera-24px.svg"),
                  )
                ),
              )
            ],
          ),
        ), SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: FlatButton(
            padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              color: Color(0xFFBFBEBE),
              onPressed: (){},
              child: Row(
                children: [],
              )),
        )
      ],
    );
  }




}