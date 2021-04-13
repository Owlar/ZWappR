import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zwappr/features/activity/ui/pages/favorite_page.dart';
import 'package:zwappr/features/authentication/models/user_model.dart';
import 'package:zwappr/features/authentication/services/authentication_service.dart';
import 'package:zwappr/features/authentication/services/i_authentication_service.dart';
import 'package:zwappr/features/authentication/ui/login_page.dart';
import 'package:zwappr/features/profile/services/i_profile_service.dart';
import 'package:zwappr/features/profile/services/profile_service.dart';
import 'package:zwappr/features/profile/ui/pages/like_page.dart';
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
  String _downloadURL;
  final imagePicker = ImagePicker();
  List<String> imageList;
  final IAuthenticationService _authenticationService = AuthenticationService();

  Future getImage() async {
    final image = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image.path);
    });
    uploadImage(_image);
    await downloadURL();
    await _profileService.updateImage(_downloadURL);
  }

  Future getGallery() async {
    final image = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = File(image.path);
    });
    uploadImage(_image);
    await downloadURL();
    await _profileService.updateImage(_downloadURL);
  }

  Future<void> downloadURL() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String downloadURL = await storage.ref(_nameOfImage).getDownloadURL();

    setState(() {
      _downloadURL = downloadURL;
    });
  }

  Future<void> uploadImage(File _image1) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String nameOfImage = "users/image" + DateTime.now().toString();
    Reference ref = storage.ref().child(nameOfImage);
    UploadTask uploadTask = ref.putFile(_image1);
    await uploadTask;

    setState(() {
      _nameOfImage = nameOfImage;
    });
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {
      print('PLS');
    });
  }

  Future<void> photoPicker() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Camera or Gallery"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Choose camera or gallery"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: new Icon(
                Icons.camera_alt,
                color: zwapprGreen,
              ),
              onPressed: () {
                getImage();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
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

  @override
  Widget build(BuildContext context) {
    Future<UserModel> futureUserModel;

    // Future <String> download;
    // download = downloadURL();
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
            SizedBox(height: 50),
            ProfilePicture(
                image: _image,
                uri: auth.currentUser.photoURL,
                camera: false,
                press: () async {
                  photoPicker();
                }),
            SizedBox(height: 20),
            auth.currentUser.displayName == null
                ? FutureBuilder<UserModel>(
                    future: futureUserModel,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data.displayName);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      // By default, show a loading spinner.
                      return CircularProgressIndicator();
                    },
                  )
                : Text(auth.currentUser.displayName.toString()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButtons(
                  icon: Icons.settings,
                  press: () {
                    print(auth.currentUser.photoURL);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsPage(image: _image)),
                    );
                  },
                ),
                IconButtons(
                  icon: Icons.edit,
                  press: () {
                    Route route = MaterialPageRoute(
                        builder: (context) => EditPage(image: _image));
                    Navigator.push(context, route).then(onGoBack);
                  },
                ),
              ],
            ),
            Button(press: () {}),
            Menu(
              text: "Likt",
              icon: Icons.check,
              press: () {
                Route route =
                    MaterialPageRoute(builder: (context) => LikePage());
                Navigator.push(context, route).then(onGoBack);
              },
            ),
            Menu(
              text: "Favoritter",
              icon: Icons.favorite,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritePage()),
                );
              },
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
    ));
  }

// SOURCES:
//https://medium.com/fabcoding/adding-an-image-picker-in-a-flutter-app-pick-images-using-camera-and-gallery-photos-7f016365d856
//https://api.flutter.dev/flutter/material/AlertDialog-class.html
}
