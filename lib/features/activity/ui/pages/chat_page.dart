import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zwappr/features/activity/models/chat_message.dart';
import 'package:zwappr/features/activity/ui/widgets/list_view_chat.dart';
import 'package:http/http.dart' as http;
import '../../../activity/models/chat_users.dart';

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

Future<Map> fetchChatMessage() async {
  final response = await http.get(
    "https://us-central1-zwappr.cloudfunctions.net/api/convo",
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "idToken": await auth.currentUser.getIdToken(true)
    },
  );
  return (jsonDecode(response.body));
}

Future<ChatUsers> addChatUser() async {
  await http.post(
    "https://us-central1-zwappr.cloudfunctions.net/api/convo",
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "idToken": await auth.currentUser.getIdToken(true)
    },
    body: jsonEncode(<String, String>{
      "toUser": "NPDjGHiQFSYyrPCmGS5r9V5j70C2",

    }),
  );

}

class _ChatPageState extends State<ChatPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    List<ChatUsers> chatUsers = [
      ChatUsers("name", "message", "https://randomuser.me/api/portraits/men/1.jpg", "date"),
     /* ChatUsers(
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
          name: "Vilde",
          message: "Harket er datteren til A-ha-stjernen Morten Harket, ",
          image: "https://randomuser.me/api/portraits/women/2.jpg",
          date: "Now"),
      ChatUsers(
          name: "Nora",
          message: "Harket mener det har påvirket henne på en måte som gjør at hun ikke klarer å fullføre ting hun har startet på.",
          image: "https://randomuser.me/api/portraits/women/3.jpg",
          date: "Yesterday"),
      ChatUsers(
          name: "Ole",
          message: "Hun forklarer at ADHD (Attention deficit hyperactivity disorder) og ADD (attention deficit disorder) er litt det samme ",
          image: "https://randomuser.me/api/portraits/men/4.jpg",
          date: "Now"),
      ChatUsers(
          name: "Line",
          message: "Samtidig påpeker hun at denne diagnosen ikke vil gjøre noe særlig forskjell i livet hennes. ",
          image: "https://randomuser.me/api/portraits/women/4.jpg",
          date: "Now"),*/
    ];
  // Future <ChatUsers> futureChatUser;
    //futureChatUser = fetchChatUser();
    Future <Map> test;
    test = fetchChatMessage();



    /*print("TESTING THIS OUT!!");
    FutureBuilder<ChatUsers>(
      future: futureChatUser,
      builder: (context, snapshot) {
        print("TEST " + snapshot.toString());
        if (snapshot.hasData) {
         // ChatUsers c = new ChatUsers(snapshot.data.name, snapshot.data.name, snapshot.data.name, snapshot.data.name);
         // chatUsers.add(c);

          //return Text(snapshot.data.displayName == null ? "GET": snapshot.data.displayName);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
*/


    FutureBuilder<Map>(
      future: test,
      builder: (context, snapshot) {
        print("TEST HALLO " + snapshot.toString());
        if (snapshot.hasData) {
          // ChatUsers c = new ChatUsers(snapshot.data.name, snapshot.data.name, snapshot.data.name, snapshot.data.name);
          // chatUsers.add(c);

          return Text(snapshot.data.toString() == null ? "GET": snapshot.data.toString());
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
    //addChatUser();
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
                    // ChatUsers c = new ChatUsers(snapshot.data.name, snapshot.data.name, snapshot.data.name, snapshot.data.name);
                    // chatUsers.add(c);

                    return Text(snapshot.data["data"][0]["participants"].toString() == null ? "GET": snapshot.data["data"][0]["participants"].toString());
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
