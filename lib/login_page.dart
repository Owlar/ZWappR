import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zwappr/authentication_service.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
              onPressed: () {
                context.read<AuthenticationService>().signIn(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );
              },
              child: Text("Logg inn"),
          ),
          RaisedButton(
            onPressed: () {
              context.read<AuthenticationService>().signInWithGoogle();
            },
            child: Image(
                image: AssetImage('assets/google_logo.png'),
                height: 70
            )
          ),
          RaisedButton(
              onPressed: () {
                context.read<AuthenticationService>().signInWithFacebook();
              },
              child: Image(
                  image: AssetImage('assets/facebook_logo.png'),
                  height: 70
              )
          ),
        ],
      )
    );
  }
}