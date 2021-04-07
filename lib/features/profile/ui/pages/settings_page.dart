import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwappr/features/profile/ui/widgets/back_btn_blue.dart';
import 'package:zwappr/features/profile/ui/widgets/icon_buttons.dart';
import 'package:zwappr/features/profile/ui/widgets/menu.dart';
import 'package:zwappr/features/profile/ui/widgets/profile_picture.dart';

import 'edit_page.dart';

class SettingsPage extends StatelessWidget {
  final File image;
  final FirebaseAuth auth = FirebaseAuth.instance;

  SettingsPage({
    Key key,
    @required this.image
  }) : super(key: key);

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
                BackBtnBlue(),
                ProfilePicture(
                    image: image,
                    uri: auth.currentUser.photoURL,
                    press: (){}
                ),
                SizedBox(height: 20,),
                auth.currentUser.displayName == null ? Text(email[1]) : Text(auth.currentUser.displayName.toString()),
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
                  text: "Varsling",
                  icon: Icons.notification_important,
                  press: () {},
                ),
                Menu(
                  text: "Kontoinnstillinger",
                  icon: Icons.account_box,
                  press: () {},
                ),
                Menu(
                  text: "Administrer adresser",
                  icon: Icons.account_tree,
                  press: () {},
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: Menu(
                    text: "Juridisk og vilkår",
                    icon: Icons.account_balance,
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