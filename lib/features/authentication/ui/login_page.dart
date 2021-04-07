import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zwappr/features/authentication/services/authentication_service.dart';
import 'package:zwappr/features/authentication/services/i_authentication_service.dart';
import 'package:zwappr/features/authentication/ui/register_page.dart';
import 'package:zwappr/features/home/ui/home_page.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Color tabBarLogin = zwapprBlack;
  Color tabBarRegister = zwapprDarkGray;

  static final IAuthenticationService _authenticationService =
      AuthenticationService();

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
            children: <Widget>[
              SizedBox(height: 42),
              SvgPicture.asset("assets/icons/zwappr_logo.svg", height: 100),
              SizedBox(height: 62),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 195,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Log inn',
                            style: new TextStyle(
                                color: tabBarLogin,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        ButtonTheme(
                          height: 10,
                          child: RaisedButton(
                            padding: const EdgeInsets.all(8.0),
                            color: tabBarLogin,
                            child: new Container(
                              decoration: new BoxDecoration(color: tabBarLogin),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 195,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                            setState(() {
                              tabBarLogin = zwapprBlack;
                              tabBarRegister = zwapprDarkGray;
                            });
                          },
                          child: Text(
                            "Registrer",
                            style: new TextStyle(
                                color: tabBarRegister,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        ButtonTheme(
                          height: 10,
                          child: RaisedButton(
                            padding: const EdgeInsets.all(8.0),
                            color: tabBarRegister,
                            child: new Container(
                              decoration:
                                  new BoxDecoration(color: tabBarRegister),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                              setState(() {
                                tabBarLogin = zwapprBlack;
                                tabBarRegister = zwapprDarkGray;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            fillColor: zwapprWhite,
                            filled: true,
                            labelText: "E-post",
                            prefixIcon: Icon(Icons.account_circle,
                                color: zwapprBlack, size: 34)),
                        controller: emailController,
                        validator: (value) {
                          if (value.isEmpty)
                            return "Vennligst skriv inn e-post";
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 4),
                      TextFormField(
                        decoration: InputDecoration(
                            fillColor: zwapprWhite,
                            filled: true,
                            labelText: "Passord",
                            prefixIcon: Icon(Icons.lock_outline,
                                color: zwapprBlack, size: 34)),
                        controller: passwordController,
                        validator: (value) {
                          if (value.isEmpty)
                            return "Vennligst skriv inn passord";
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 32),
                      ButtonTheme(
                        minWidth: 220,
                        child: RaisedButton(
                          color: zwapprBlack,
                          textColor: zwapprWhite,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              final user = (await _authenticationService.signIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim()));
                              if (user != null) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => HomePage()));
                              }
                            }
                          },
                          child: Text("Logg inn"),
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 10),
              Row(children: <Widget>[
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                      child: Divider(
                        color: zwapprDarkGray,
                        thickness: 2,
                      )),
                ),
                Text(
                  "Or",
                  style: new TextStyle(
                      color: zwapprDarkGray,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                      child: Divider(
                        color: zwapprDarkGray,
                        thickness: 2,
                      )),
                ),
              ]),
              SizedBox(height: 10),
              SignInButton(
                Buttons.FacebookNew,
                onPressed: () async {
                  final userCredential =
                      (await _authenticationService.signInWithFacebook());
                  if (userCredential != null) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
              ),
              SignInButton(
                Buttons.Google,
                onPressed: () async {
                  final userCredential =
                      (await _authenticationService.signInWithGoogle());
                  if (userCredential != null) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Text('Privacy policy and licence agreement'),
                ),
              ),
            ],
          )),
      resizeToAvoidBottomInset: false,
    );
  }
}
