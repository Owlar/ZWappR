import 'package:flutter/material.dart';
import 'package:zwappr/features/activity/ui/pages/chat_page.dart';



class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.chat)),
                  Tab(icon: Icon(Icons.favorite))
                ]
              ),
              title: Text("Aktivitet")
            ),
              body: TabBarView(
                children: [
                  ChatPage(),
                  Icon(Icons.favorite)
                ],
              ),
          ),
      ),
    );
  }
}