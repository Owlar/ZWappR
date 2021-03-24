import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zwappr/features/activity/methods/favorite_card.dart';
import 'package:zwappr/features/things/models/thing_model.dart';
import 'package:zwappr/features/things/services/i_things_service.dart';
import 'package:zwappr/features/things/services/things_service.dart';


class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  static final IThingsService _thingsService = ThingsService();

  Future<List<ThingModel>> _getThingsFromService() async {
    final List<ThingModel> _thingsFromService = (await _thingsService.getAll());
    return _thingsFromService;
  }
  @override
  void initState() {
    super.initState();
    setState(() {
      _getThingsFromService();

    });
  }

  Future<FutureOr> onGoBack(dynamic value) {
    setState(() {
      _getThingsFromService();

    });
  }

  @override
  Widget build(BuildContext context) {
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
            future: _getThingsFromService(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator()
                );
              } else {
                print('############################# REDO #############################');
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
