import 'package:flutter/material.dart';
import 'package:zwappr/features/profile/ui/profliePicture.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Profile"),
        backgroundColor: Color(0xFF1E1E),
      ),
        body:  Center(
          child: ProfilePicture(),
          
        )
    );
  }
}