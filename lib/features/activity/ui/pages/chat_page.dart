import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zwappr/features/activity/methods/conversation_list_view.dart';
import 'package:zwappr/features/activity/services/chat_service.dart';
import 'package:zwappr/features/activity/services/i_chat_service.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

import '../../../activity/models/chat_users.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

final FirebaseAuth auth = FirebaseAuth.instance;

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static final IChatService _chatService = ChatService();

  Future<Map> test = _chatService.get();
  String _now;
  Timer _everySecond;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {
      test = _chatService.get();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        print('paused');
        break;
      case AppLifecycleState.resumed:
        print('resume');
        break;
      case AppLifecycleState.inactive:
        print('inactive');
        break;
      case AppLifecycleState.detached:
        print('detached');
        break;
    }
  }

  void updatePage(){
    setState(() {
      test = _chatService.get();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ChatUsers> chatUsers = [];
    List<String> conversationList = [];
    //_chatService.create("NPDjGHiQFSYyrPCmGS5r9V5j70C2");

    return Scaffold(
      body: Container(
        height: double.infinity,
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
                                fontSize: 32, fontWeight: FontWeight.bold
                            ),
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
                      hintText: "Søk...",
                      hintStyle: TextStyle(color: zwapprBlack),
                      prefixIcon: Icon(
                        Icons.search,
                        color: zwapprBlack,
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
                   if(!snapshot.hasData){
                      return Center(child: Text("Ingen Meldinger"));
                    }
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator()
                      );
                    } else {
                    
                     for (int i = 0; i < snapshot.data["size"]; i++) {
                        String id = auth.currentUser.uid;
                        String formatted = "";
                        String msg = "";
                        int userId = 0;
                        int myId;

                        conversationList.add(
                            snapshot.data["data"][i]["convoID"].toString()
                        );

                        if (snapshot.data["data"][i]["participants"]["userInfo"]
                          [0]["id"].toString() == id) {
                            userId = 1;
                            myId = 0;
                        } else {
                          userId = 0;
                          myId = 1;
                        }

                        if (snapshot.data["data"][i]["previewMsg"] != null) {
                          int sec = snapshot.data["data"][i]["previewMsg"]
                              ["time"]["_seconds"];
                          int nanoSec = snapshot.data["data"][i]["previewMsg"]
                              ["time"]["_nanoseconds"];

                          Timestamp time = new Timestamp(sec, nanoSec);
                          DateTime date = time.toDate();
                          final DateFormat formatter =
                              DateFormat('dd.MM.yy H:m');
                          formatted = formatter.format(date);

                          msg = snapshot.data["data"][i]["previewMsg"]
                                  ["content"]
                              .toString();
                        }

                        ChatUsers c = new ChatUsers(
                          snapshot.data["data"][i]["participants"]["userInfo"][userId]
                                  ["displayName"]
                              .toString(),
                          msg,
                          snapshot.data["data"][i]["participants"]["userInfo"][userId]
                                  ["imageID"]
                              .toString(),
                          formatted,
                            snapshot.data["data"][i]["participants"]["userInfo"][userId]
                            ["thingImageID"], snapshot.data["data"][i]["participants"]["userInfo"][myId]
                        ["thingImageID"]
                        );
                        chatUsers.add(c);
                      }
                    }
                    return buildConversationListView(chatUsers, conversationList, onGoBack);
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
