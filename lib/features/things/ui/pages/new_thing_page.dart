import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zwappr/features/things/models/thing_model.dart';
import 'package:zwappr/features/things/services/i_things_service.dart';
import 'package:zwappr/features/things/services/things_service.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

class NewThingPage extends StatefulWidget {
  @override
  _NewThingPageState createState() => _NewThingPageState();
}

class _NewThingPageState extends State<NewThingPage> {
  static final IThingsService _thingsService = ThingsService();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  File _image;
  final imagePicker = ImagePicker();
  List<String> imageList;
  String _nameOfImage;
  String _downloadURL;

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
    String nameOfImage = "things/image" + DateTime.now().toString();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_screen.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 42),
              Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: "Tittel"),
                        controller: titleController,
                        validator: (value) {
                          if (value.isEmpty)
                            return "Vennligst skriv inn tittel";
                          else
                            return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Beskrivelse"),
                        controller: descriptionController,
                        validator: (value) {
                          if (value.isEmpty)
                            return "Vennligst skriv inn beskrivelse";
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 10),
                      RaisedButton(
                        color: zwapprBlack,
                        textColor: zwapprWhite,
                        onPressed: () async {
                          if (_formKey.currentState.validate() && _downloadURL != null) {
                            final newThing = ThingModel(
                              title: titleController.text.trim(),
                              description: descriptionController.text.trim(),
                              imageUrl: _downloadURL,
                            );
                            _thingsService.create(newThing);
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Lag Gjenstand"),
                      ),
                    ],
                  )),
              SizedBox(height: 10),
              Expanded(
                child: FlatButton(
                  onPressed: () async {
                    photoPicker();
                    await downloadURL();
                  },
                  child: (
                      _image == null
                      ? Image.network(
                          "https://images.unsplash.com/photo-1488109811119-98431feb6929?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80")
                      : Image.file(_image)
                  ),
                ),
              ),
            ],
          )),
      resizeToAvoidBottomInset: false,
    );
  }
}
