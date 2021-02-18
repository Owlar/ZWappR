import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zwappr/authentication_service.dart';

class RegisterPage extends StatelessWidget {
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
    );
  }
}