import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zwappr/features/authentication/models/user_model.dart';
import 'package:zwappr/features/profile/services/i_profile_service.dart';
import 'package:zwappr/features/profile/services/profile_service.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

class ProfilePicture extends StatelessWidget {
  final File _image;
  final String uri;
  final bool camera;
  final VoidCallback press;

  const ProfilePicture({
    Key key,
    @required File image,
    @required this.press,
    this.camera,
    this.uri,
  })  : _image = image,
        super(key: key);

  static final IProfileService _profileService = ProfileService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    String pic;
    String imageID;
    Future<UserModel> futureUserModel;
    futureUserModel = _profileService.get();
    if (uri != null) {
      pic = uri + "?type=large";
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: SizedBox(
        height: 115,
        width: 115,
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            FutureBuilder<UserModel>(
              future: futureUserModel,
              builder: (context,AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  /*imageID = snapshot.data.imageID;
                  print("Has data " + snapshot.data.imageID);
                  print(_image.toString());
                  return CircleAvatar(
                      backgroundImage: _image == null
                          ? NetworkImage(snapshot.data.imageID)
                          : FileImage(_image));*/

                  return Text("error");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  CircularProgressIndicator();
                  }
                if(snapshot.data.imageID == null){
                  return CircleAvatar(
                    backgroundImage: _image == null
                        ? (uri == null
                        ? AssetImage("assets/images/profile_test.png")
                        : NetworkImage(pic))
                        : FileImage(_image),
                  );
                }else{
                 /* print('No data');
                  return CircleAvatar(
                    backgroundImage: _image == null
                        ? (uri == null
                        ? AssetImage("assets/images/profile_test.png")
                        : NetworkImage(pic))
                        : FileImage(_image),
                  );*/
                  imageID = snapshot.data.imageID;
                  print("Has data " + snapshot.data.imageID);
                  print(_image.toString());
                  return CircleAvatar(
                      backgroundImage: _image == null
                          ? NetworkImage(snapshot.data.imageID)
                          : FileImage(_image));
                }

              },
            ),
            /*FutureBuilder<UserModel>(
              future: futureUserModel,
              builder: (context, snapshot) {
                if (snapshot.hasData && (snapshot.data.imageID != null)) {
                  imageID = snapshot.data.imageID;
                  print("Has data " + snapshot.data.imageID);
                  print(_image.toString());
                  return CircleAvatar(
                      backgroundImage: _image == null
                          ? NetworkImage(snapshot.data.imageID)
                          : FileImage(_image));
                }else if ((snapshot.data.imageID == null)|| snapshot.hasError ) {
                  print('No data');
                  return CircleAvatar(
                    backgroundImage: _image == null
                        ? (uri == null
                            ? AssetImage("assets/images/profile_test.png")
                            : NetworkImage(pic))
                        : FileImage(_image),
                  );
                }
                return CircularProgressIndicator();
              },
            ),*/
            camera == true
                ? Positioned(
                    right: -12,
                    bottom: 0,
                    child: SizedBox(
                        height: 46,
                        width: 46,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(color: zwapprWhite)),
                          color: zwapprLightGray,
                          onPressed: press, //photoPicker,
                          child: SvgPicture.asset(
                              "assets/icons/photo_camera-24px.svg"),
                        )),
                  )
                : Text(""),
          ],
        ),
      ),
    );
  }
}
