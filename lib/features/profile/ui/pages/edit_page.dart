import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zwappr/features/profile/ui/pages/settings_page.dart';
import 'package:zwappr/features/profile/ui/widgets/menu.dart';
import 'package:zwappr/features/profile/ui/widgets/profile_picture.dart';

import '../widgets/icon_buttons.dart';


class EditPage extends StatelessWidget {
  final File image;
 EditPage({Key key, @required this.image}) : super(key: key);
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
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
                    image: image,
                    uri: auth.currentUser.photoURL,
                    press: (){}
                    ),
                SizedBox(height: 20,),
                Text(auth.currentUser.displayName.toString()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButtons(
                      icon: Icons.settings,
                      press: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SettingsPage(image: image)),
                        );
                      },
                    ),
                    IconButtons(
                      icon: Icons.edit,
                      press: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditPage(image: image)),
                        );
                      },
                    ),
                  ],
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
                    text: "Tekst",
                    icon: Icons.text_fields,
                    press: () {},
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}