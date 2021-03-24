import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zwappr/features/activity/methods/favorite_card.dart';
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

  Future<List<ThingModel>> _getFavoriteFromService() async {
    final List<ThingModel> _thingsFromService = (await _favoriteService.getAll());
    return _thingsFromService;
  }
  @override
  void initState() {
    super.initState();
    setState(() {
      _getFavoriteFromService();

    });
  }

  Future<FutureOr> onGoBack(dynamic value) {
    setState(() {
      _getFavoriteFromService();

    });
  }

  @override
  Widget build(BuildContext context) {
    _favoriteService.create("3beWSQVGraC97py7ZpUm");
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_screen.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: FutureBuilder<List>(
            future: _getFavoriteFromService(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
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
