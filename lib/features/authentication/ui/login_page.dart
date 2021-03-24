import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zwappr/features/authentication/services/authentication_service.dart';
import 'package:zwappr/features/authentication/services/i_authentication_service.dart';
import 'package:zwappr/features/authentication/ui/register_page.dart';
import 'package:zwappr/features/home/ui/home_page.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  static final IAuthenticationService _authenticationService = AuthenticationService();

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
                    decoration: InputDecoration(
                        fillColor: zwapprWhite,
                        filled: true,
                        labelText: "E-post"
                    ),
                    controller: emailController,
                    validator: (value) {
                      if (value.isEmpty) return "Vennligst skriv inn e-post";
                      else return null;
                    },
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    decoration: InputDecoration(
                        fillColor: zwapprWhite,
                        filled: true,
                        labelText: "Passord"
                    ),
                    controller: passwordController,
                    validator: (value) {
                      if (value.isEmpty) return "Vennligst skriv inn passord";
                      else return null;
                    },
                  ),
                  SizedBox(height: 42),
                  RaisedButton(
                    color: zwapprBlack,
                    textColor: zwapprWhite,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        final user = (await _authenticationService.signIn(email: emailController.text.trim(), password: passwordController.text.trim()));
                        if (user != null) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                        }
                      }
                    },
                    child: Text("Logg inn"),
                  ),
                ],
              )
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
            SignInButton(
              Buttons.Google,
              onPressed: () async {
                final userCredential = (await _authenticationService.signInWithGoogle());
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