import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:zwappr/features/chat/ui/widgets/list_view_chat.dart';

import '../model/chat_users.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    List<ChatUsers> chatUsers = [
      ChatUsers(
          name: "Ina",
          message: "Awesome Setup",
          image: "https://randomuser.me/api/portraits/women/1.jpg",
          date: "Now"),
      ChatUsers(
          name: "Oscar",
          message: "Helst så fort som mulig. Tar litt tid å få fikset UI",
          image:  "https://randomuser.me/api/portraits/men/1.jpg",
          date: "Yesterday"),
      ChatUsers(
          name: "Magnus",
          message: "Det hadde gått helt i glemmeboka",
          image:  "https://randomuser.me/api/portraits/men/5.jpg",
          date: "31 Mar"),
      ChatUsers(
          name: "Emilio",
          message: "hey, glemte den forelesingen saa jeg dro kl 1400. kom hjem har fiksa facebook navn og profil bilde",
          image:  "https://randomuser.me/api/portraits/men/2.jpg",
          date: "28 Mar"),
    ];

    return Scaffold(
      body: Container(decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background_screen.png"),
          fit: BoxFit.cover,
        ),
      ),
        child: Center(
          child: Column(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Meldinger",
                              style:
                                  TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListViewChat(chatUsers: chatUsers),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

