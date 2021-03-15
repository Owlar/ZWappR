import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwappr/features/things/models/thing_model.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

class NewThingPage extends StatefulWidget {
  @override
  _NewThingPageState createState() => _NewThingPageState();
}

class _NewThingPageState extends State<NewThingPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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
            children: <Widget> [
              SizedBox(height: 42),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Tittel",
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: "Beskrivelse",
                ),
              ),
              SizedBox(height: 42),
              FlatButton(
                onPressed: () {
                  // TODO: Let user take picture with camera or choose existing picture from gallery (Like in profile page)
                },
                child: Image.network("https://images.unsplash.com/photo-1488109811119-98431feb6929?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80")
              ),
              SizedBox(height: 10),
              RaisedButton(
                color: zwapprBlack,
                textColor: zwapprWhite,
                onPressed: () async {
                  final newThing = ThingModel(
                      title: titleController.text.trim(),
                      description: descriptionController.text.trim(),
                      imageUrl: "https://images.unsplash.com/photo-1488109811119-98431feb6929?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80"
                  );
                  Navigator.pop(context);
                },
                child: Text("Lag Gjenstand"),
              ),
            ],
          )
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}