import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zwappr/features/things/models/thing_model.dart';
import 'package:zwappr/features/things/services/i_things_service.dart';
import 'package:zwappr/features/things/services/things_service.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

class EditThingPage extends StatefulWidget {
  final ThingModel thingToBeEdited;
  const EditThingPage({Key key, @required this.thingToBeEdited}) : super(key: key);

  @override
  _EditThingPageState createState() => _EditThingPageState(thingToBeEdited);
}

class _EditThingPageState extends State<EditThingPage> {
  static final IThingsService _thingsService = ThingsService();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController exchangeValueController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  File _image;
  final imagePicker = ImagePicker();
  List<String> imageList;
  String _nameOfImage;
  String _downloadURL;

  ThingModel thingToBeEdited;

  _EditThingPageState(this.thingToBeEdited);

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
  void initState() {
    titleController.text = thingToBeEdited.title;
    descriptionController.text = thingToBeEdited.description;
    exchangeValueController.text = thingToBeEdited.exchangeValue;
    super.initState();
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
                          if (_formKey.currentState.validate()) {
                            if ( _downloadURL != null) {
                              await downloadURL();
                            }
                            final newThing = ThingModel(
                              uid: thingToBeEdited.uid,
                              title: titleController.text.trim(),
                              description: descriptionController.text.trim(),
                              imageUrl: _downloadURL == null ? thingToBeEdited.imageUrl : _downloadURL,
                            );
                            _thingsService.put(newThing);
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Rediger"),
                      ),
                    ],
                  )),
              SizedBox(height: 10),
              Expanded(
                child: FlatButton(
                  onPressed: () async {
                    photoPicker();
                  },
                  child: (
                      _image == null
                          ? Image.network(thingToBeEdited.imageUrl)
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