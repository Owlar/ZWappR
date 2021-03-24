import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zwappr/features/authentication/services/authentication_service.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final AuthenticationService _authenticationService = AuthenticationService();

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
              SvgPicture.asset("assets/icons/zwappr_logo.svg", height: 100),
              SizedBox(height: 62),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: displayNameController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        fillColor: zwapprWhite,
                        filled: true,
                        labelText: "Brukernavn",
                      ),
                      validator: (value) {
                        if (value.isEmpty) return "Vennligst lag brukernavn";
                        else return null;
                      },
                    ),
                    SizedBox(height: 4),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        fillColor: zwapprWhite,
                        filled: true,
                        labelText: "E-post",
                      ),
                      validator: (value) {
                        if (value.isEmpty) return "Vennligst skriv inn e-post";
                        else return null;
                      },
                    ),
                    SizedBox(height: 4),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        fillColor: zwapprWhite,
                        filled: true,
                        labelText: "Passord",
                      ),
                      validator: (value) {
                        if (value.isEmpty) return "Vennligst lag passord";
                        else return null;
                      },
                    ),
                    SizedBox(height: 42),
                    RaisedButton(
                      color: zwapprBlack,
                      textColor: zwapprWhite,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          final user = (await _authenticationService.register(
                              displayName: displayNameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim()
                          ));
                          if (user != null) {
                            //Back to login page
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: Text("Lag bruker"),
                    ),
                  ],
                )
              ),
            ],
          )
        ),
        resizeToAvoidBottomInset: false,
    );
  }
}