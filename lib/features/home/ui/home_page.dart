import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zwappr/features/activity/ui/pages/activity_page.dart';
import 'package:zwappr/features/things/ui/things_page.dart';
import 'package:zwappr/features/feed/providers/feedback_position_provider.dart';
import 'package:zwappr/features/feed/ui/feed_page.dart';
import 'package:zwappr/features/map/ui/map_page.dart';
import 'package:zwappr/features/profile/ui/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: 5,
        controller: _pageController,
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        itemBuilder: (BuildContext context, int index) {
          switch(index) {
            case 0:
              return ChangeNotifierProvider(create: (context) => FeedbackPositionProvider(), child: FeedPage());
            case 1:
              return ActivityPage();
            case 2:
              return ThingsPage();
            case 3:
              return MapPage();
            case 4:
              return ProfilePage();
            default:
              throw "No page with index: $index";
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black54,
          selectedItemColor: Theme.of(context).primaryColor,
          type: BottomNavigationBarType.fixed,
          iconSize: 30,
          currentIndex: _selectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Hjem",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "Aktivitet",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.post_add),
              label: "Ting",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: "Kart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profil",
            ),
          ],
          onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    _pageController.jumpToPage(index);
    print(index);
  }

}

