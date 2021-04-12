import 'dart:async';

import 'package:flutter/material.dart';

import 'package:zwappr/features/activity/services/favorite_service.dart';
import 'package:zwappr/features/activity/services/i_favorite_service.dart';
import 'package:zwappr/features/profile/methods/like_card.dart';
import 'package:zwappr/features/profile/ui/widgets/back_btn_blue.dart';
import 'package:zwappr/features/things/models/thing_model.dart';

class LikePage extends StatefulWidget {
  @override
  _LikePageState createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  static final IFavoriteService _favoriteService = FavoriteService();

  Future<List<ThingModel>> _getAllFavoritesFromService() async {
    final List<ThingModel> _favoriteFromService =
        (await _favoriteService.getAll());
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_screen.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            BackBtnBlue(),
            Text(
              "Likte gjenstander",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Expanded(
              child: FutureBuilder<List>(
                future: _getAllFavoritesFromService(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    return Center(child: Text("Ingen favoritter"));
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.all(14.0),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final thing = snapshot.data[index];
                        return buildLikeCard(thing, context, onGoBack);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
