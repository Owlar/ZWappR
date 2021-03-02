import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zwappr/features/profile/ui/pages/settings_page.dart';
import 'package:zwappr/features/profile/ui/widgets/menu.dart';
import 'package:zwappr/features/profile/ui/widgets/profile_picture.dart';

import '../widgets/button.dart';
import '../widgets/icon_buttons.dart';
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
  Future getGallery() async {
    final image = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50
    );
    setState(() {
      _image = File(image.path);
    });
  }
  final FirebaseAuth auth = FirebaseAuth.instance;



  /*void inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    // here you write the codes to input the data into firestore
  }*/

  Future<void> photoPicker() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title:  Text("Camera or Gallery"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Choose camera or gallery"),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: new Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                ),
                onPressed: () {
                  getImage();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: new Icon(
                  Icons.insert_photo,
                  color: Colors.black,
                ),
                onPressed: () {
                  getGallery();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }



  @override
  Widget build(BuildContext context) {
    List providerData = auth.currentUser.providerData.toString().split(',');
    List email = providerData[1].split(':');
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
                ProfilePicture(
                    image:_image,
                    uri: auth.currentUser.photoURL,
                    press: photoPicker),
                SizedBox(height: 20,),
                auth.currentUser.displayName == null ? Text(email[1]) : Text(auth.currentUser.displayName.toString()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButtons(
                      icon: Icons.settings,
                      press: (){
                        print(auth.currentUser.photoURL);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SettingsPage(image: _image)),
                        );
                      },
                    ),
                    IconButtons(
                      icon: Icons.edit,
                      press: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditPage(image: _image)),
                        );
                      },
                    ),
                  ],
                ),
                Button(press: () {},),
                Menu(
                  text: "Likt",
                  icon: Icons.star,
                  press: () {},
                ),
                Menu(
                  text: "Favoritter",
                  icon: Icons.favorite,
                  press: () {},
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: Menu(
                    text: "Logg ut",
                    icon: Icons.logout,
                    press: () {},
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  // SOURCES:
  //https://medium.com/fabcoding/adding-an-image-picker-in-a-flutter-app-pick-images-using-camera-and-gallery-photos-7f016365d856
  //https://api.flutter.dev/flutter/material/AlertDialog-class.html
}


