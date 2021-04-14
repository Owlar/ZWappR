import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zwappr/features/activity/methods/favorite_card.dart';
import 'package:zwappr/features/activity/services/favorite_service.dart';
import 'package:zwappr/features/activity/services/i_favorite_service.dart';
import 'package:zwappr/features/things/models/thing_model.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  static final IFavoriteService _favoriteService = FavoriteService();
  final Set _updateCard = Set();

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

  Icon favoriteIcon = Icon(Icons.favorite);
  Color colorIcon = zwapprRed;
  String currentUid;
  bool flag = true;

  @override
  Widget build(BuildContext context) {
     //_favoriteService.create("i4MOW9STsTNTzXHBGcw0");
   //  _favoriteService.create("e2HZ1qJqgrllu2Y1F6dF");
  //   _favoriteService.create("ui5PnAVC3gYGU8aw48tB");
    //delete("3ReG0PYyEAUio7qc1lsE");
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
                  return StatefulBuilder(builder:
                      (BuildContext context, StateSetter newStateForCard) {
                    final thing = snapshot.data[index];
                    return buildFavoriteCard(
                        thing, context, newStateForCard, index);
                  });
                },
              );
            }
          },
        ),
      ),
    );
  }

  Card buildFavoriteCard(ThingModel thing, BuildContext context,
      StateSetter newStateForCard, int index) {
    return Card(
        margin: EdgeInsets.fromLTRB(2.0, 14.0, 2.0, 0),
        child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(children: <Widget>[
              Container(
                  child: Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: thing.imageUrl == null
                      ? Image.asset("assets/images/thing_image_placeholder.png")
                      : Image.network(thing.imageUrl),
                ),
                SizedBox(width: 10),
                Expanded(
                    flex: 4,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(thing.title == null ? "" : thing.title,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis),
                          SizedBox(height: 4),
                          Text(
                              thing.description == null
                                  ? ""
                                  : thing.description,
                              style: TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis),
                          SizedBox(height: 10),
                          Text(
                              thing.exchangeValue == null
                                  ? ""
                                  : thing.exchangeValue + " kr",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis),
                          SizedBox(height: 4),
                          Text(
                              thing.condition == null
                                  ? ""
                                  : "Brukstilstand: " + thing.condition,
                              style: TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis),
                          Text(
                              thing.category == null
                                  ? ""
                                  : "Kategori: " + thing.category,
                              style: TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis),
                        ])),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        IconButton(
                          icon: favoriteIcon,
                          color: colorIcon,
                          onPressed: () {
                            if(flag) {
                              flag = false;
                              newStateForCard(() {
                                favoriteIcon =
                                    Icon(Icons.favorite_border_outlined);
                                colorIcon = zwapprBlack;
                              });
                              _favoriteService.delete(thing.uid);
                              Timer(Duration(seconds: 5), () {
                                setState(() {
                                  favoriteIcon = Icon(Icons.favorite);
                                  colorIcon = zwapprRed;
                                });
                              });

                              print('TRUE');
                            }else{
                              flag = true;
                              newStateForCard(() {
                                favoriteIcon = Icon(Icons.favorite);
                                colorIcon = zwapprRed;
                              });
                              _favoriteService.create(thing.uid);
                            }
                          },
                        ),
                        SizedBox(height: 40),
                      ],
                    ))
              ])),
            ])));
  }
}
