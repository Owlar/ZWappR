import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwappr/features/activity/models/chat_users.dart';

import 'conversation_list.dart';

class ListViewChat extends StatelessWidget {
  const ListViewChat({
    Key key,
    @required this.chatUsers,
    @required this.conversationList,
  }) : super(key: key);

  final List<ChatUsers> chatUsers;
  final List<String> conversationList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatUsers.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 16),
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
          ),
        );
      },
    );
  }
}
