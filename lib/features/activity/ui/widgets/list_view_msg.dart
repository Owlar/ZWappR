import 'package:flutter/cupertino.dart';
import 'package:zwappr/features/activity/models/chat_message.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

class ListViewMsg extends StatelessWidget {
  const ListViewMsg({
    Key key,
    @required this.messages,
  }) : super(key: key);

  final List<ChatMessage> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      shrinkWrap: true,
      reverse: true,
      padding: EdgeInsets.only(top: 85, bottom: 60),
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          padding:
          EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
          child: Align(
            alignment: (messages[index].messageType == "receiver"
                ? Alignment.topLeft
                : Alignment.topRight),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: (messages[index].messageType == "receiver"
                      ? Radius.circular(0)
                      : Radius.circular(20)),
                  bottomRight: (messages[index].messageType == "receiver"
                      ? Radius.circular(20)
                      : Radius.circular(0)),
                ),
                color: (messages[index].messageType == "receiver"
                    ? zwapprLightGray
                    : zwapprWhite),
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                messages[index].messageContent,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        );
      },
    );
  }
}
