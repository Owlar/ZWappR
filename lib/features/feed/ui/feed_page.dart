import 'package:flutter/material.dart';
import 'package:zwappr/features/authentication/ui/login_page.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          // TEMPORARY Log out button
          child: RaisedButton(
            color: Colors.black,
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text("Logg ut")
          )
        )
    );
  }
}