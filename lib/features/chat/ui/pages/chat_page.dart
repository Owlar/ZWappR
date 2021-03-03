import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zwappr/features/chat/ui/widgets/list_view_chat.dart';

import '../models/chat_users.dart';

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
          message: "Husk å skrive om arkitektur, løst koblet kode, repository, services, MVC...",
          image: "https://randomuser.me/api/portraits/women/1.jpg",
          date: "Now"),
      ChatUsers(
          name: "Oscar",
          message: "I dette kapittel ble det snakket om hvordan prosjektgruppen har implementer ZWappR systemet",
          image: "https://randomuser.me/api/portraits/men/1.jpg",
          date: "Yesterday"),
      ChatUsers(
          name: "Magnus",
          message: "Før implementeringen av autentisering så var REST API'et fullstendig åpent.",
          image: "https://randomuser.me/api/portraits/men/3.jpg",
          date: "Now"),
      ChatUsers(
          name: "Emilio",
          message: "Hei alle sammen",
          image: "https://randomuser.me/api/portraits/men/2.jpg",
          date: "Yesterday"),
      ChatUsers(
          name: "Ina",
          message: "Husk å skrive om arkitektur, løst koblet kode, repository, services, MVC...",
          image: "https://randomuser.me/api/portraits/women/1.jpg",
          date: "Now"),
      ChatUsers(
          name: "Oscar",
          message: "I dette kapittel ble det snakket om hvordan prosjektgruppen har implementer ZWappR systemet",
          image: "https://randomuser.me/api/portraits/men/1.jpg",
          date: "Yesterday"),
      ChatUsers(
          name: "Magnus",
          message: "Før implementeringen av autentisering så var REST API'et fullstendig åpent.",
          image: "https://randomuser.me/api/portraits/men/3.jpg",
          date: "Now"),
      ChatUsers(
          name: "Emilio",
          message: "Hei alle sammen",
          image: "https://randomuser.me/api/portraits/men/2.jpg",
          date: "Yesterday"),

      ChatUsers(
          name: "Ina",
          message: "Husk å skrive om arkitektur, løst koblet kode, repository, services, MVC...",
          image: "https://randomuser.me/api/portraits/women/1.jpg",
          date: "Now"),
      ChatUsers(
          name: "Oscar",
          message: "I dette kapittel ble det snakket om hvordan prosjektgruppen har implementer ZWappR systemet",
          image: "https://randomuser.me/api/portraits/men/1.jpg",
          date: "Yesterday"),
      ChatUsers(
          name: "Magnus",
          message: "Før implementeringen av autentisering så var REST API'et fullstendig åpent.",
          image: "https://randomuser.me/api/portraits/men/3.jpg",
          date: "Now"),
      ChatUsers(
          name: "Emilio",
          message: "Hei alle sammen",
          image: "https://randomuser.me/api/portraits/men/2.jpg",
          date: "Yesterday"),


    ];

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
                ListViewChat(chatUsers: chatUsers),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
