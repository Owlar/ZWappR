import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zwappr/features/profile/ui/profile_picture.dart';

import 'button.dart';
import 'edit_page.dart';
import 'icon_buttons.dart';
import 'menu.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                /*ProfilePicture(
                    image: _image,
                    press: photoPicker),*/
                SizedBox(height: 20,),
                Text(auth.currentUser.email.toString()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButtons(
                      icon: Icons.settings,
                      press: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SettingsPage()),
                        );
                      },
                    ),
                    IconButtons(
                      icon: Icons.edit,
                      press: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditPage()),
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
                  text: "E-postinnstillinger",
                  icon: Icons.email,
                  press: () {},
                ),
                Menu(
                  text: "Kontoinnstillingerr",
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