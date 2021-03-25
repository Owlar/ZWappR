import 'package:flutter/material.dart';
import 'package:zwappr/features/activity/ui/pages/chat_page.dart';
import 'package:zwappr/features/activity/ui/pages/favorite_page.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: zwapprBlue,
            bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.chat)),
                  Tab(icon: Icon(Icons.favorite))
                ]
            ),
            title: Center(
                child: Text("Aktivitet")
            ),
        ),
        body: TabBarView(
          children: [
            ChatPage(),
            FavoritePage(),
          ],
        ),
      ),
    );
  }
}