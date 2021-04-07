import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zwappr/features/profile/services/i_profile_service.dart';
import 'package:zwappr/features/profile/services/profile_service.dart';
import 'package:zwappr/features/profile/ui/pages/settings_page.dart';
import 'package:zwappr/features/profile/ui/widgets/back_btn_blue.dart';
import 'package:zwappr/features/profile/ui/widgets/menu.dart';
import 'package:zwappr/features/profile/ui/widgets/profile_picture.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

import '../widgets/icon_buttons.dart';

class EditPage extends StatefulWidget {
  final File image;

  EditPage({Key key, @required this.image}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  static final IProfileService _profileService = ProfileService();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController newName = TextEditingController();
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final imagePicker = ImagePicker();

  String _nameOfImage;
  String _downloadURL;
  File _image;

  Future getImage() async {
    final image = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image.path);
    });
    uploadImage(_image);
  }

  Future getGallery() async {
    final image = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = File(image.path);
    });
    uploadImage(_image);
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
    List providerData = auth.currentUser.providerData.toString().split(',');
    List email = providerData[1].split(':');

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
            BackBtnBlue(),
            ProfilePicture(
                image: _image,
                uri: auth.currentUser.photoURL,
                camera: true,
                press: () async {
                  photoPicker();

                }),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButtons(
                  icon: Icons.settings,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SettingsPage(image: widget.image)),
                    );
                  },
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (newName.text != "") {
                          _profileService.put(newName.text);
                        }

                        if (_downloadURL != null) {
                          await _profileService.updateImage(_downloadURL);
                        }
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Lagre',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.save),
                      iconSize: 36,
                      onPressed: () async {
                        if(newName.text == "" && _nameOfImage == null){
                          print('No changes ' + _nameOfImage.toString());
                        }else {
                          if (newName.text != "") {
                            _profileService.put(newName.text);
                          }

                          if (_nameOfImage != null) {
                            await downloadURL();
                            await _profileService.updateImage(_downloadURL);
                          }
                          FocusScope.of(context).unfocus();
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    email[1],
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                )),
            TextField(
              controller: newName,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                  fillColor: zwapprWhite,
                  filled: true,
                  labelText: "Nytt brukernavn",
                  prefixIcon:
                      Icon(Icons.account_circle, color: zwapprBlack, size: 34)),
            ),
          ],
        ),
      ),
    ));
  }
}
