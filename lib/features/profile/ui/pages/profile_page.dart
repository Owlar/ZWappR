import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zwappr/features/authentication/models/user_model.dart';
import 'package:zwappr/features/authentication/services/authentication_service.dart';
import 'package:zwappr/features/authentication/services/i_authentication_service.dart';
import 'package:zwappr/features/authentication/ui/login_page.dart';
import 'package:zwappr/features/profile/services/i_profile_service.dart';
import 'package:zwappr/features/profile/services/profile_service.dart';
import 'package:zwappr/features/profile/ui/pages/settings_page.dart';
import 'package:zwappr/features/profile/ui/widgets/menu.dart';
import 'package:zwappr/features/profile/ui/widgets/profile_picture.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

import '../widgets/button.dart';
import '../widgets/icon_buttons.dart';
import 'edit_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _image;
  final FirebaseAuth auth = FirebaseAuth.instance;
  static final IProfileService _profileService = ProfileService();
  String _nameOfImage;
  final imagePicker = ImagePicker();
  List<String> imageList;
  final IAuthenticationService _authenticationService = AuthenticationService();

  Future getImage() async {
    final image = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image.path);
    });
    uploadImage(_image);
  }

  Future getGallery() async {
    final image = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50
    );
    setState(() {
      _image = File(image.path);
    });
    uploadImage(_image);
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

  Future<String> downloadURL() async {
    FirebaseStorage storage =  FirebaseStorage.instance;
    String downloadURL = await storage.ref(_nameOfImage).getDownloadURL();

    return downloadURL;

  }

  Future<void> uploadImage(File _image1) async {
    FirebaseStorage storage =   FirebaseStorage.instance;
    String nameOfImage = "users/image" + DateTime.now().toString();
    Reference ref = storage.ref().child(nameOfImage);
    UploadTask uploadTask = ref.putFile(_image1);
    await uploadTask;
    setState(() {
      _nameOfImage = nameOfImage;
    });

  }
  @override
  Widget build(BuildContext context) {
    Future <UserModel> futureUserModel;

    Future <String> download;
    download = downloadURL();
    futureUserModel = _profileService.get();
    List providerData = auth.currentUser.providerData.toString().split(',');
    List email = providerData[1].split(':');
    //String url;

    return Scaffold(
        body: Container(
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
                    press: (){
                      photoPicker();
                    }
                ),
                SizedBox(height: 20,),
                auth.currentUser.displayName == null ? FutureBuilder<UserModel>(
                  future: futureUserModel,
                  builder: (context, snapshot) {
                    print("TEST " + snapshot.toString());
                    if (snapshot.hasData) {
                      return Text(snapshot.data.displayName);
                      //return Text(snapshot.data.displayName == null ? "GET": snapshot.data.displayName);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ):Text(auth.currentUser.displayName.toString()),
                 //auth.currentUser.displayName == null ? Text(email[1]) : Text(auth.currentUser.displayName.toString()),
                FutureBuilder<String>(
                  future: download,
                  builder: (context, snapshot) {

                    if (snapshot.hasData) {
                      _profileService.updateImage(snapshot.data.toString());
                      return Text("");
                      //return Text(snapshot.data.displayName == null ? "GET": snapshot.data.displayName);
                    } else if (snapshot.hasError) {
                      return Text("");
                    }
                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
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
                Button(press: () {
                }),
                Menu(
                  text: "Likt",
                  icon: Icons.star,
                  press: (){},
                ),
                Menu(
                  text: "Favoritter",
                  icon: Icons.favorite,
                  press: (){},
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
                      _authenticationService.signOut();
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


