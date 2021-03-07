import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zwappr/features/authentication/ui/login_page.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZWappR',
      theme: _zwapprTheme,
      home: LoginPage(),
    );
  }
}

final ThemeData _zwapprTheme = _buildShrineTheme();

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: zwapprLightGray,
    primaryColor: zwapprBlue,
    /*buttonTheme: base.buttonTheme.copyWith(
      buttonColor: zwapprBlue,
      colorScheme: base.colorScheme.copyWith(
        secondary: zwapprLightGray,
      ),
    ),
    buttonBarTheme: base.buttonBarTheme.copyWith(
      buttonTextTheme: ButtonTextTheme.accent,
    ),
    scaffoldBackgroundColor: zwapprWhite,
    cardColor: zwapprWhite,
    textSelectionColor: zwapprBlue,
    errorColor: zwapprRed,*/
    // TODO: Add the text themes (103)
    // TODO: Add the icon themes (103)
    // TODO: Decorate the inputs (103)
  );
}