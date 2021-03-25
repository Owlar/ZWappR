import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zwappr/features/activity/methods/favorite_card.dart';
import 'package:zwappr/features/activity/models/chat_users.dart';
import 'package:zwappr/features/activity/services/favorite_service.dart';
import 'package:zwappr/features/activity/services/i_favorite_service.dart';
import 'package:zwappr/features/things/models/thing_model.dart';
import 'package:zwappr/features/things/services/i_things_service.dart';
import 'package:zwappr/features/things/services/things_service.dart';


class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  static final IFavoriteService _favoriteService = FavoriteService();

  Future<List<ThingModel>> _getAllFavoritesFromService() async {
     final List<ThingModel> _favoriteFromService = (await _favoriteService.getAll());
      return _favoriteFromService;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _getAllFavoritesFromService();
    });
  }

  Future<FutureOr> onGoBack(dynamic value) {
    setState(() {
      _getAllFavoritesFromService();
    });
  }

  @override
  Widget build(BuildContext context) {
    //_favoriteService.create("3ReG0PYyEAUio7qc1lsE");
    return Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_screen.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: FutureBuilder<List>(
            future: _getAllFavoritesFromService(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}")
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator()
                );
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.all(14.0),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final thing = snapshot.data[index];
                    return buildFavoriteCard(thing, context, onGoBack);
                  },
                );
              }
            },
          ),
        ),
    );
  }
}
