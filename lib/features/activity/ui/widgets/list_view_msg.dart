import 'package:flutter/cupertino.dart';
import 'package:zwappr/features/activity/models/chat_message.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

class ListViewMsg extends StatelessWidget {
  final List<ChatMessage> messages;

  const ListViewMsg({
    Key key,
    @required this.messages,
  }) : super(key: key);

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
          EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
          child: Align(
            alignment: (messages[index].messageType == "receiver"
                ? Alignment.topLeft
                : messages[index].messageType == "sender" ? Alignment.topRight : Alignment.topCenter),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: (messages[index].messageType == "receiver"
                      ? Radius.circular(0)
                      :  messages[index].messageType == "sender" ? Radius.circular(20) : Radius.circular(20)),
                  bottomRight: (messages[index].messageType == "receiver"
                      ? Radius.circular(20)
                      :  messages[index].messageType == "sender" ? Radius.circular(0) : Radius.circular(20)),
                ),
                color: (messages[index].messageType == "receiver"
                    ? zwapprLightGray
                    : messages[index].messageType == "sender" ? zwapprWhite : zwapprBlue),
              ),
              padding: EdgeInsets.all(16),
              child:  messages[index].messageImageOne == null ? Text(
                messages[index].messageContent,
                style: TextStyle(fontSize: 15),
              ):Container(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Container(
                      height: 80,
                        width: 80,
                        child: Image.network(messages[index].messageImageOne)),
                    Container(
                        height: 80,
                        width: 80,
                        child: Image.network(messages[index].messageImageTwo)),
                    Text(
                      messages[index].messageContent,
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
               // NetworkImage(chatUsers[index].image),
            ),
          ),
        );
      },
    );
  }
}
