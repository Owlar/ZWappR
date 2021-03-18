import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwappr/features/activity/models/chat_message.dart';
import 'package:zwappr/features/activity/services/chat_service.dart';
import 'package:zwappr/features/activity/services/i_chat_service.dart';
import 'package:zwappr/features/activity/ui/widgets/chat_info_person.dart';
import 'package:zwappr/features/activity/ui/widgets/list_view_msg.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

class ChatDetailPage extends StatefulWidget {
  String name;
  String image;
  String msgId;

  ChatDetailPage({
    @required this.name,
    @required this.image,
    @required this.msgId,
  });

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> with WidgetsBindingObserver{
  final TextEditingController newMessage = TextEditingController();
  static final IChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> getId() async {
    return await _firebaseAuth.currentUser.getIdToken(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    switch(state){
      case AppLifecycleState.paused:
        print('paused');
        break;
      case AppLifecycleState.resumed:
        print('resume');
        break;
      case AppLifecycleState.inactive:
        print('inactive');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<Map> test;
    test = _chatService.getMsg(widget.msgId);
    List<ChatMessage> messages = [];


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
            FutureBuilder<Map>(
              future: test,
              builder: (context, snapshot) {
                //print("TEST HALLO " + snapshot.toString());
                if (snapshot.hasData) {
                    String id = _firebaseAuth.currentUser.uid;
                    String from;
                  //ChatMessage(messageContent: snapshot.data["data"][0]["content"].toString(), messageType: "receiver");
                 for(int i = 0; i < snapshot.data["size"]; i++) {
                    if(snapshot.data["data"][i]["from"].toString() == id){
                        from = "sender";
                    }else{
                      from = "receiver";
                    }
                    messages.add(ChatMessage(messageContent: snapshot.data["data"][i]["content"].toString(), messageType: from));
                  }
                  return ListViewMsg(messages: messages);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return CircularProgressIndicator();
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
                          color: zwapprBlue,
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
                          color: zwapprBlue,
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
                          color: zwapprBlue,
                          size: 26,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: newMessage,
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: zwapprBlack),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        _chatService.createMsg(widget.msgId, newMessage.text);
                        messages.add(ChatMessage(messageContent: "pls", messageType: "receiver"));
                        setState(() {
                         // messages.add(ChatMessage(messageContent: "pls", messageType: "receiver"));
                        });
                       /* Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatDetailPage(name: widget.name, image: widget.image, msgId: widget.msgId )),
                        );*/
                      },
                      child: Icon(
                        Icons.send,
                        color: zwapprBlue,
                        size: 26,
                      ),
                      backgroundColor: zwapprWhite,
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
                color: zwapprWhite,
                child: ChatInfoPerson(name: widget.name, image: widget.image),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

