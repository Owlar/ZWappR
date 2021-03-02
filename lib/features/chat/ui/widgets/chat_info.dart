
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatInfo extends StatelessWidget {
  const ChatInfo({
    Key key, image,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(right: 16),
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.black,),
            ),
            SizedBox(width: 2,),
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://randomuser.me/api/portraits/men/5.jpg"),
              maxRadius: 20,
            ),
            SizedBox(width: 12,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Gunnar", style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),),
                  SizedBox(height: 6,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}