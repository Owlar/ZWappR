import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zwappr/features/profile/services/i_proflie_service.dart';
import 'package:zwappr/features/profile/services/proflie_service.dart';
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
  static final IProfileService _profileService = ProfileService();
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
                      _profileService.put(newName.text);
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
