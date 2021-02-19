import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:zwappr/authentication_service.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              SizedBox(height: 50),
              SvgPicture.asset("assets/icons/zwappr_logo.svg", height: 100),
              SizedBox(height: 100),
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
              RaisedButton(
                color: Colors.black,
                textColor: Colors.white,
                onPressed: () {
                  context.read<AuthenticationService>().register(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  ).then((_) {
                    // Back to login page
                    Navigator.pop(context);
                  });
                },
                child: Text("Lag bruker"),
              ),
            ],
          )
        )
    );
  }
}