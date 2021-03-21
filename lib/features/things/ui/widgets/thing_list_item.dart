/*
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwappr/features/things/models/thing_model.dart';
import 'package:zwappr/features/things/services/i_things_service.dart';
import 'package:zwappr/features/things/services/things_service.dart';
import 'package:zwappr/features/things/ui/pages/edit_thing_page.dart';
import 'package:zwappr/features/things/ui/pages/things_page.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

class ThingListItem extends StatelessWidget {
  static final IThingsService _thingsService = ThingsService();
  final ThingModel thing;

  const ThingListItem({Key key, @required this.thing}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    Card buildCard(thing, BuildContext context, FutureOr onGoBack) {
      return Card(
          margin: EdgeInsets.fromLTRB(2.0, 14.0, 2.0, 0),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(2.0, 12.0, 12.0, 12.0),
              child: Column(children: <Widget>[
                Container(
                    child: Row(children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: thing.imageUrl == null
                        ? Image.asset(
                            "assets/images/thing_image_placeholder.png")
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
                      child: Column(children: [
                        Visibility(
                            child: PopupMenuButton<String>(
                          itemBuilder: (BuildContext context) {
                            return Choices.getAll.map((String choice) {
                              return PopupMenuItem<String>(
                                  value: choice, child: Text(choice));
                            }).toList();
                          },
                          child: Icon(Icons.more_vert, size: 30),
                          onSelected: (
                            String value,
                          ) {
                            switch (value) {
                              case Choices.Edit:
                                Route route = MaterialPageRoute(
                                    builder: (context) =>
                                        EditThingPage(thingToBeEdited: thing));
                                Navigator.push(context, route).then(onGoBack);
                                break;
                              case Choices.Delete:
                                _thingsService.delete(thing.uid);

                                break;
                              default:
                                print("Couldn't find case for value $value");
                            }
                          },
                        )),
                        SizedBox(height: 10),
                        // TODO: Ternary: If thing is active, green color and "Aktiv", else red color and "Inaktiv"
                        Text(
                          "Aktiv",
                          style: TextStyle(
                              fontSize: 18, backgroundColor: zwapprGreen),
                        )
                      ]))
                ])),
              ])));
    }
  }

  void choiceAction(String value, BuildContext context) {
    switch (value) {
      case Choices.Edit:
        /*Route route = MaterialPageRoute(builder: (context) => EditThingPage(thingToBeEdited: thing));
        Navigator.push(context, route).then(onGoBack);*/
        /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditThingPage(thingToBeEdited: thing))
        );*/
        break;
      case Choices.Delete:
        _thingsService.delete(thing.uid);

        break;
      default:
        print("Couldn't find case for value $value");
    }
  }
}

class Choices {
  static const String Edit = "Edit";
  static const String Delete = "Delete";

  static const List<String> getAll = <String>[Edit, Delete];
}
*/