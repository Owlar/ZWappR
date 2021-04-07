import 'package:flutter/material.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

class BackBtnBlue extends StatelessWidget {
  const BackBtnBlue({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Align(

        alignment: Alignment.topLeft,
        child: IconButton(

          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 30,
          color: zwapprBlue,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
