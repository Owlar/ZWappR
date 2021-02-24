import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zwappr/features/profile/ui/settings_page.dart';

import 'edit_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _image;
  final imagePicker = ImagePicker();

  Future getImage() async {
    final image = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_screen.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: SizedBox(
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
                                color: Color(0xFFE0E0E0),
                                onPressed: getImage,
                                child: SvgPicture.asset("assets/icons/photo_camera-24px.svg"),
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                ), SizedBox(height: 20,),
                Text("Tina Olsen"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:20, vertical: 0),
                          child: SizedBox(
                            height: 46,
                            width: 46,
                            child: FlatButton(
                              child: new Icon(
                                Icons.settings,
                                size: 36,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SettingsPage()),
                                );
                              },
                            ),
                          ),
                        ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:20, vertical: 0),
                      child: SizedBox(
                        height: 46,
                        width: 46,
                          child: FlatButton(
                            child: new Icon(
                              Icons.edit,
                              size: 36,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditPage()),
                              );
                            },
                          ),
                        ),
                    ),
                  ],
                ),
                Padding(
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
                        onPressed: (){},
                        child: Row(
                          children: [Expanded(child: Text("Inviter",
                            textAlign: TextAlign.center,))],
                        )),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      FlatButton(
                        child: new Icon(
                          Icons.star,
                          size: 36,
                          color: Colors.black,
                        ),
                        onPressed: (){},
                      ),
                      Text("Likt"),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      FlatButton(
                        child: new Icon(
                          Icons.favorite,
                          size: 36,
                          color: Colors.black,

                        ),
                        onPressed: (){},
                      ),
                      Text("Favoritter"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

}