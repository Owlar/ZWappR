import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zwappr/features/authentication/services/authentication_service.dart';
import 'package:zwappr/features/authentication/services/i_authentication_service.dart';
import 'package:zwappr/features/authentication/ui/register_page.dart';
import 'package:zwappr/utils/colors/color_theme.dart';
import 'package:zwappr/features/home/ui/home_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  static final IAuthenticationService _authenticationService = AuthenticationService();

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
              color: zwapprBlack,
              textColor: zwapprWhite,
              onPressed: () async {
                final user = (await _authenticationService.signIn(email: emailController.text.trim(), password: passwordController.text.trim()));
                if (user != null) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                }
              },
              child: Text("Logg inn"),
            ),
            RaisedButton(
              color: zwapprBlack,
              textColor: zwapprWhite,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text("Registrer"),
            ),
            SizedBox(height: 30),
            SignInButton(
              Buttons.FacebookNew,
              onPressed: () async {
                final userCredential = (await _authenticationService.signInWithFacebook());
                if (userCredential != null) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                }
              },
            ),
          ],
        )
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}