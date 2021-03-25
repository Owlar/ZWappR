import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

Card buildFavoriteCard(thing, BuildContext context, FutureOr onGoBack) {
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
                        Text(thing.description == null ? "" : thing.description,
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
                  child: Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite),
                    color: zwapprRed,
                    onPressed: () {
                      print('favorite pressed');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: zwapprDarkGray,
                    onPressed: () {
                      print('delete pressed ');
                    },
                  ),

                ],
              ))
            ])),
          ])));
}
