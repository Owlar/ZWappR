import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zwappr/features/authentication/services/authentication_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hjem"),
            RaisedButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
              child: Text("Logg ut"),
            ),
          ],
        ),
      ),
    );
  }
  
}