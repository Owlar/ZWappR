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

Future<ChatUsers> fetchChatUser() async {
  final response = await http.get(
    "https://us-central1-zwappr.cloudfunctions.net/api/convo/X6BTw56tqsgZLRbgD8vQ?p=0",
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "idToken": await auth.currentUser.getIdToken(true)
    },
  );
  if (response.statusCode == 200) {
    print("statusCode" + response.statusCode.toString());
    return ChatUsers.fromJson(jsonDecode(response.body)["data"]);
  } else {
    print("statusCode" + response.statusCode.toString());
    throw Exception('Failed to fetch data');
  }
}

Future<void> addChatUser(String userId) async {
  await http.post(
    "https://us-central1-zwappr.cloudfunctions.net/api/convo",
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "idToken": await auth.currentUser.getIdToken(true)
    },
    body: jsonEncode(<String, String>{
      "toUser": userId,
    }),
  );
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static final IChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    List<ChatUsers> chatUsers = [];
    // Future <ChatUsers> futureChatUser;
    //futureChatUser = fetchChatUser();
    Future<Map> test;
    test = _chatService.get();

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
                  builder: (context, snapshot) {
                    //print("TEST HALLO " + snapshot.toString());
                    if (snapshot.hasData) {


                      for (int i = 0; i < snapshot.data["size"]; i++) {
                        String formatted = "";
                        String msg = "";

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
                      return Text("");
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
                ListViewChat(chatUsers: chatUsers),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
