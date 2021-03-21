import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwappr/features/activity/models/chat_users.dart';

import 'conversation_list.dart';

class ListViewChat extends StatelessWidget {
  final List<ChatUsers> chatUsers;
  final List<String> conversationList;
  final VoidCallback press;

  const ListViewChat({
    Key key,
    @required this.chatUsers,
    @required this.conversationList,
    @required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatUsers.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10),
      physics: NeverScrollableScrollPhysics(),
      //physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          child: ConversationList(
            name: chatUsers[index].name,
            message: chatUsers[index].message,
            image: chatUsers[index].image,
            date: chatUsers[index].date,
            msgId: conversationList[index],
            isMessageRead: (index == 0 || index == 3) ? true : false,
            press: press,
          ),
        );
      },
    );
  }
}
