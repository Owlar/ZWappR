import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zwappr/features/authentication/services/authentication_service.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();

  final AuthenticationService _authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_screen.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget> [
              SizedBox(height: 22),
              SvgPicture.asset("assets/icons/zwappr_logo.svg", height: 100),
              SizedBox(height: 70),
              TextField(
                controller: displayNameController,
                decoration: InputDecoration(
                  labelText: "Brukernavn",
                ),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "E-post",
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Passord",
                ),
              ),
              SizedBox(height: 10),
              RaisedButton(
                color: zwapprBlack,
                textColor: zwapprWhite,
                onPressed: () async {
                  final user = (await _authenticationService.register(
                      displayName: displayNameController.text.trim(),
                      email: emailController.text.trim(),
                      password: passwordController.text.trim()
                  ));
                  if (user != null) {
                    //Back to login page
                    Navigator.pop(context);
                  }
                },
                child: Text("Lag bruker"),
              ),
            ],
          )
        ),
        resizeToAvoidBottomInset: false,
    );
  }
}