import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zwappr/features/profile/ui/pages/profile_page.dart';
import 'package:zwappr/features/profile/ui/pages/settings_page.dart';
import 'package:zwappr/features/profile/ui/widgets/menu.dart';
import 'package:zwappr/features/profile/ui/widgets/profile_picture.dart';

import '../widgets/icon_buttons.dart';

class EditPage extends StatelessWidget {
  final File image;

  EditPage({Key key, @required this.image}) : super(key: key);
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController newName = TextEditingController();

  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    List providerData = auth.currentUser.providerData.toString().split(',');
    List email = providerData[1].split(':');

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
    }

    Future uploadPic(BuildContext context) async {}

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
                  image: image, uri: auth.currentUser.photoURL, press: () {}),
              SizedBox(
                height: 20,
              ),
              //auth.currentUser.displayName == null ? Text(email[1]) : Text(auth.currentUser.displayName.toString()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButtons(
                    icon: Icons.settings,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage(image: image)
                        ),
                      );
                    },
                  ),
                  IconButtons(
                    icon: Icons.save,
                    press: () {
                      update(newName.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  ),
                ],
              ),
              TextField(
                controller: newName,
                decoration: InputDecoration(
                  labelText: "Brukernavn",
                ),
              ),
              Menu(
                text: "Om deg selv",
                icon: Icons.book,
                press: () {},
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                  ),
                ),
                child: Menu(
                  text: "tekst",
                  icon: Icons.text_fields,
                  press: () {
                    print(auth.currentUser.providerData.toString());
                    print(email[1]);
                  },
                ),
              ),
            ],
          ),
        ),
    ));
  }
}
