import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zwappr/features/authentication/ui/login_page.dart';
import 'package:zwappr/features/color/color_theme.dart';
import 'package:zwappr/features/profile/ui/pages/settings_page.dart';
import 'package:zwappr/features/profile/ui/widgets/menu.dart';
import 'package:zwappr/features/profile/ui/widgets/profile_picture.dart';
import 'package:http/http.dart' as http;
import '../widgets/button.dart';
import '../widgets/icon_buttons.dart';
import 'edit_page.dart';

import 'package:firebase_storage/firebase_storage.dart';

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



  Future<void> dis() async {
    auth.currentUser.getIdToken(true).then((idToken) async => {
      await http.get(
        "https://us-central1-zwappr.cloudfunctions.net/api/users/me",
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "idToken": idToken
        },

      )
    });
  }

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
                  color: zwapprGreen,
                ),
                onPressed: () {
                  getImage();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: new Icon(
                  Icons.insert_photo,
                  color: zwapprGreen,
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
  Future<void> update(String name) async {

   auth.currentUser.getIdToken(true).then((idToken) async => {
   await http.put(
   "https://us-central1-zwappr.cloudfunctions.net/api/users/me",
   headers: <String, String>{
   "Content-Type": "application/json; charset=UTF-8",
   "idToken": idToken
   },
   body: jsonEncode(<String, String>{
   "displayName": name
   }),
   )
  });
   Future<void> dis() async {
     auth.currentUser.getIdToken(true).then((idToken) async => {
       await http.get(
         "https://us-central1-zwappr.cloudfunctions.net/api/users/me",
         headers: <String, String>{
           "Content-Type": "application/json; charset=UTF-8",
           "idToken": idToken
         },

       )
     });
   }


    /*await http.put(
      "https://us-central1-zwappr.cloudfunctions.net/api/users/me",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8" + idToken
      },
      body: jsonEncode(<String, String>{
        "displayName": name
      }),
    );*/

  }
  uploadPic(File _image1) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String url;
    Reference ref = storage.ref().child("users/image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_image1);
    uploadTask.whenComplete(() {
      url = ref.getDownloadURL() as String;
    }).catchError((onError) {
      print(onError);
    });
    return url;
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
                    camera: true,
                    press: (){photoPicker();
                    uploadPic(_image);}

                ),
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
                    press: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
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


