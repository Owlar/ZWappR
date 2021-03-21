import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zwappr/features/activity/models/chat_users.dart';
import 'package:zwappr/features/activity/ui/pages/chat_detail_page.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

ListView buildConversationListView(List<ChatUsers> chatUsers, List<String> conversationList, FutureOr onGoBack) {
  return ListView.builder(
    itemCount: chatUsers.length,
    shrinkWrap: true,
    padding: EdgeInsets.only(top: 10),
    physics: NeverScrollableScrollPhysics(),
    //physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) {
      return Container(
        child: GestureDetector(

          onTap: () {
            Route route = MaterialPageRoute(builder: (context) => ChatDetailPage(name: chatUsers[index].name, image: chatUsers[index].image, msgId:  conversationList[index] ));
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
                        backgroundImage: NetworkImage(chatUsers[index].image),
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
                                chatUsers[index].name,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                chatUsers[index].message,
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
                  chatUsers[index].date,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold

                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}