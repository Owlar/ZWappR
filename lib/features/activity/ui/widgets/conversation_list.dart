import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwappr/features/activity/ui/pages/chat_detail_page.dart';
import 'package:zwappr/features/activity/ui/pages/chat_page.dart';
import 'package:zwappr/utils/colors/color_theme.dart';


class ConversationList extends StatefulWidget {
  String name;
  String message;
  String image;
  String date;
  String msgId;
  bool isMessageRead;
  VoidCallback press;
  ConversationList({
    @required this.name,
    @required this.press,
    @required this.message,
    @required this.image,
    @required this.date,
    @required this.isMessageRead,
    @required this.msgId,
  });

  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {

  FutureOr onGoBack(dynamic value) {


      ChatPage().createState().onGoBack(value);

  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: /*widget.press,*/() {
        Route route = MaterialPageRoute(builder: (context) => ChatDetailPage(name: widget.name, image: widget.image, msgId: widget.msgId ));
        Navigator.push(context, route).then(onGoBack);
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.image),
                    maxRadius: 30,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.message,
                            style: TextStyle(
                                fontSize: 14,
                                color: zwapprBlack,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.date,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold

              ),
            ),
          ],
        ),
      ),
    );
  }
}
