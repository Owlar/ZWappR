import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwappr/features/chat/ui/model/chat_message.dart';
import 'package:zwappr/features/chat/ui/widgets/chat_info_person.dart';

class ChatDetailPage extends StatefulWidget {
  String name;
  String image;


  ChatDetailPage(
      {@required this.name,

        @required this.image,

      });
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  @override
  Widget build(BuildContext context) {
    List<ChatMessage> messagesReverse = [

      ChatMessage(messageContent: "FIRST!", messageType: "receiver"),
      ChatMessage(messageContent: "kult hahah?", messageType: "receiver"),
      ChatMessage(messageContent: "Hei, paa", messageType: "sender"),
      ChatMessage(messageContent: "kult hahah?", messageType: "receiver"),
      ChatMessage(messageContent: "Hei, paa", messageType: "receiver"),
      ChatMessage(messageContent: "kult hahah?", messageType: "receiver"),
      ChatMessage(messageContent: "AspectRatio, a widget that attempts to fit within the parent's constraints ", messageType: "sender"),
      ChatMessage(messageContent: "Hei, paa", messageType: "receiver"),
      ChatMessage(messageContent: "kult hahah?", messageType: "receiver"),
      ChatMessage(messageContent: "Hei, paa", messageType: "sender"),
      ChatMessage(messageContent: "kult hahah?", messageType: "receiver"),
      ChatMessage(messageContent: "Hei, paa", messageType: "receiver"),
      ChatMessage(messageContent: "kult hahah?", messageType: "receiver"),
      ChatMessage(messageContent: "LAST! ", messageType: "sender"),

    ];
    List<ChatMessage> messages = messagesReverse.reversed.toList();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_screen.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[


            ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              reverse: true,
              padding: EdgeInsets.only(top: 85, bottom: 60),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (messages[index].messageType == "receiver"
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: (messages[index].messageType == "receiver"
                              ? Radius.circular(0)
                              : Radius.circular(20)),
                          bottomRight: (messages[index].messageType == "receiver"
                              ? Radius.circular(20)
                              : Radius.circular(0)),
                        ),
                        color: (messages[index].messageType == "receiver"
                            ? Colors.grey.shade300
                            : Colors.white),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(
                        messages[index].messageContent,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.attach_file,
                          color: Colors.black,
                          size: 26,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.black,
                          size: 26,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                          size: 26,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.send,
                        color: Colors.black,
                        size: 26,
                      ),
                      backgroundColor: Colors.white,
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 90,
                width: double.infinity,
                color: Colors.white,
                child: ChatInfoPerson(name: widget.name, image: widget.image),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
