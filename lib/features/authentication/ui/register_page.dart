import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zwappr/features/authentication/services/authentication_service.dart';
import 'package:zwappr/features/authentication/ui/login_page.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Color tabBarLogin = zwapprDarkGray;
  Color tabBarRegister = zwapprBlack;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 195,
                    child: Column(
                      children: [
                        Text(
                          "Logg inn",
                          style: new TextStyle(color: tabBarLogin,  fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        ButtonTheme(
                          height: 10,
                          child: RaisedButton(
                            padding: const EdgeInsets.all(8.0),
                            color: tabBarLogin,
                            child: new Container(
                              decoration: new BoxDecoration(color: tabBarLogin),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginPage())
                              );
                              setState(() {
                                tabBarRegister = zwapprBlack;
                                tabBarLogin = zwapprDarkGray;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 195,
                    child: Column(
                      children: [
                        Text(
                          "Registrer",
                          style: new TextStyle(color: tabBarRegister, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        ButtonTheme(
                          height: 10,
                          child: RaisedButton(
                            padding: const EdgeInsets.all(8.0),
                            color: tabBarRegister,
                            child: new Container(
                              decoration: new BoxDecoration(color: tabBarRegister),
                            ),
                            onPressed: () {},
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