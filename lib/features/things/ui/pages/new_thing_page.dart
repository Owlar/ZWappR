import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zwappr/features/things/models/thing_model.dart';
import 'package:zwappr/features/things/services/i_things_service.dart';
import 'package:zwappr/features/things/services/things_service.dart';
import 'package:zwappr/features/things/ui/widgets/back_btn_blue.dart';
import 'package:zwappr/features/things/utils/list_categories.dart';
import 'package:zwappr/features/things/utils/list_conditions.dart';
import 'package:zwappr/utils/colors/color_theme.dart';
import 'package:zwappr/utils/location/user_geo_position.dart';

class NewThingPage extends StatefulWidget {
  @override
  _NewThingPageState createState() => _NewThingPageState();
}

class _NewThingPageState extends State<NewThingPage> {
  static final IThingsService _thingsService = ThingsService();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController exchangeValueController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final imagePicker = ImagePicker();

  List<String> imageList;
  File _image;
  String _nameOfImage;
  String _downloadURL;

  String _condition;
  String _category;

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
              BackBtnBlue(),
              Expanded(
                child: FlatButton(
                  onPressed: () async {
                    photoPicker();
                  },
                  child: (
                      _image == null
                          ? SvgPicture.asset(
                          "assets/images/thing_image_placeholder.svg")
                          : Image.file(_image)
                  ),
                ),
              ),
              SizedBox(height: 10),
              Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            fillColor: zwapprWhite,
                            filled: true,
                            labelText: "Tittel"
                        ),
                        controller: titleController,
                        textCapitalization: TextCapitalization.sentences,
                        validator: (value) {
                          if (value.isEmpty)
                            return "Vennligst skriv inn tittel";
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 4),
                      TextFormField(
                        decoration: InputDecoration(
                            fillColor: zwapprWhite,
                            filled: true,
                            labelText: "Bytteverdi"
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        controller: exchangeValueController,
                        validator: (value) {
                          if (value.isEmpty)
                            return "Vennligst legg til bytteverdi";
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 4),
                      TextFormField(
                        decoration: InputDecoration(
                            fillColor: zwapprWhite,
                            filled: true,
                            labelText: "Beskrivelse"
                        ),
                        controller: descriptionController,
                        textCapitalization: TextCapitalization.sentences,
                        validator: (value) {
                          if (value.isEmpty)
                            return "Vennligst skriv inn beskrivelse";
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 4),
                      DropdownButtonFormField(
                        decoration: InputDecoration(fillColor: zwapprWhite, filled: true, labelText: "Kategori"),
                        validator: (value) => value == null ? "Må legge til en kategori" : null,
                        items: categories.map((String category) {
                          return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category));
                        }).toList(),
                        value: _category,
                        onChanged: (String value) {
                          setState(() {
                            _category = value;
                            print(_category);
                          });
                        },
                      ),
                      SizedBox(height: 4),
                      DropdownButtonFormField(
                        decoration: InputDecoration(fillColor: zwapprWhite, filled: true, labelText: "Brukstilstand"),
                        validator: (value) => value == null ? "Må legge til een brukstilstand" : null,
                        items: conditions.map((String condition) {
                          return DropdownMenuItem<String>(
                              value: condition,
                              child: Text(condition));
                          }).toList(),
                        value: _condition,
                        onChanged: (String value) {
                          setState(() {
                             _condition = value;
                             print(_condition);
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      RaisedButton(
                        color: zwapprBlack,
                        textColor: zwapprWhite,
                        onPressed: () async {
                          if (_formKey.currentState.validate() && _nameOfImage != null) {
                            if ( _downloadURL == null) {
                              await downloadURL();
                            }
                            final userPosition = await getUserGeoPosition();
                            var newThing = ThingModel(
                              title: titleController.text.trim(),
                              description: descriptionController.text.trim(),
                              imageUrl: _downloadURL == null
                                  ? "https://media.discordapp.net/attachments/786267164550103133/821110641083285544/unknown.png"
                                  : _downloadURL,
                              exchangeValue: exchangeValueController.text.trim(),
                              condition: _condition == null
                                  ? "Ukjent"
                                  : _condition,
                              category: _category == null
                                  ? "Annet"
                                  : _category,
                              latitude: userPosition.latitude,
                              longitude: userPosition.longitude
                            );
                            await _thingsService.create(newThing);
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Legg ut"),
                      ),
                    ],
                  )),
            ],
          )),
      resizeToAvoidBottomInset: false,
    );
  }
}
