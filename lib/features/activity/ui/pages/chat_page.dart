import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zwappr/features/activity/models/chat_message.dart';
import 'package:zwappr/features/activity/services/chat_service.dart';
import 'package:zwappr/features/activity/services/i_chat_service.dart';
import 'package:zwappr/features/activity/ui/widgets/list_view_chat.dart';
import 'package:http/http.dart' as http;
import '../../../activity/models/chat_users.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

final FirebaseAuth auth = FirebaseAuth.instance;


class _ChatPageState extends State<ChatPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static final IChatService _chatService = ChatService();

  Future<Map> test = _chatService.get();


  @override
  Widget build(BuildContext context) {
    List<ChatUsers> chatUsers = [];
    List<String> conversationList = [];
    // Future <ChatUsers> futureChatUser;
    //futureChatUser = fetchChatUser();

    //Future<Map> test = _chatService.get();

    //_chatService.createMsg("9qQ5yKyMKKpXNYMivraM", "YO! wazzzup");
    //_chatService.create("NPDjGHiQFSYyrPCmGS5r9V5j70C2");

    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_screen.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Meldinger",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: EdgeInsets.all(8),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                    ),
                  ),
                ),
                FutureBuilder<Map>(
                  future: test,
                  builder: (context, AsyncSnapshot snapshot) {
                    //print("TEST HALLO " + snapshot.toString());
                    if (snapshot.hasData) {


                      for (int i = 0; i < snapshot.data["size"]; i++) {

                        String formatted = "";
                        String msg = "";
                        conversationList.add(snapshot.data["data"][i]["convoID"].toString());
                        if (snapshot.data["data"][i]["previewMsg"] != null) {

                          int sec = snapshot.data["data"][i]["previewMsg"]["time"]["_seconds"];
                          int nanoSec = snapshot.data["data"][i]["previewMsg"]["time"]["_nanoseconds"];

                          Timestamp time = new Timestamp(sec, nanoSec);
                          DateTime date = time.toDate();
                          final DateFormat formatter = DateFormat('dd.MM.yy H:m');
                          formatted = formatter.format(date);

                          msg = snapshot.data["data"][i]["previewMsg"]["content"].toString();
                        }

                        ChatUsers c = new ChatUsers(
                            snapshot.data["data"][i]["participants"]["user1"]["displayName"].toString(),
                            msg,
                            snapshot.data["data"][i]["participants"]["user1"]["imageID"].toString(),
                            formatted);
                        chatUsers.add(c);
                      }
                      return ListViewChat(chatUsers: chatUsers, conversationList: conversationList);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
