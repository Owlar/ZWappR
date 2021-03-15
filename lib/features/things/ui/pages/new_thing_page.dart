
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Tittel"
                      ),
                      controller: titleController,
                      validator: (value) {
                        if (value.isEmpty) return "Vennligst skriv inn tittel";
                        else return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Beskrivelse"
                      ),
                      controller: descriptionController,
                      validator: (value) {
                        if (value.isEmpty) return "Vennligst skriv inn beskrivelse";
                        else return null;
                      },
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      color: zwapprBlack,
                      textColor: zwapprWhite,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          final newThing = ThingModel(
                              title: titleController.text.trim(),
                              description: descriptionController.text.trim(),
                              imageUrl: "https://images.unsplash.com/photo-1488109811119-98431feb6929?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80"
                          );
                          _thingsService.create(newThing);
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Lag Gjenstand"),
                    ),
                  ],
                )
              ),
              SizedBox(height: 42),
              FlatButton(
                  onPressed: () {
                    // TODO: Let user take picture with camera or choose existing picture from gallery (Like in profile page)
                  },
                  child: Image.network("https://images.unsplash.com/photo-1488109811119-98431feb6929?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80")
              ),
            ],
          )
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}