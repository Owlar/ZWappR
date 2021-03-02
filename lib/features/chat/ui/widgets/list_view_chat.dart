import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/chat_users.dart';
import 'conversation_list.dart';

class ListViewChat extends StatelessWidget {
  const ListViewChat({
    Key key,
    @required this.chatUsers,
  }) : super(key: key);

  final List<ChatUsers> chatUsers;

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
            isMessageRead: (index == 0 || index == 3) ? true : false,
          ),
        );
      },
    );
  }
}
