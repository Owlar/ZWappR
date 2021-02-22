import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'file:///C:/Users/Gunther/AndroidStudioProjects/zwappr/lib/features/authentication/services/authentication_service.dart';
import 'file:///C:/Users/Gunther/AndroidStudioProjects/zwappr/lib/features/authentication/ui/register_page.dart';

class LoginPage extends StatelessWidget {
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
            SizedBox(height: 22),
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
            SizedBox(height: 10),
            RaisedButton(
              color: Colors.black,
              textColor: Colors.white,
              onPressed: () {
                context.read<AuthenticationService>().signIn(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );
              },
              child: Text("Logg inn"),
            ),
            RaisedButton(
              color: Colors.black,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text("Registrer"),
            ),
            SizedBox(height: 30),
            SignInButton(
              Buttons.FacebookNew,
              onPressed: () {
                context.read<AuthenticationService>().signInWithFacebook();
              },
            ),
          ],
        )
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}