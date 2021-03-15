import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwappr/features/things/models/thing_model.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

class ThingListItem extends StatelessWidget {
  final ThingModel thing;

  const ThingListItem({
    Key key,
    @required this.thing
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(2.0, 14.0, 2.0, 0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(2.0, 12.0, 12.0, 12.0),
        child: Column(
          children: <Widget> [
            Container(
              child: Row(
                  children: <Widget> [
                    Expanded(
                      flex: 2,
                      child: thing.imageUrl == null
                          ? Image.network("https://images.unsplash.com/photo-1488109811119-98431feb6929?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80")
                          : Image.network(thing.imageUrl),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget> [
                          Text(
                              thing.title,
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis
                          ),
                          SizedBox(height: 10),
                          Text(
                              thing.description,
                              style: TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis
                          ),
                        ]
                      )
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Visibility(
                            child: PopupMenuButton<String>(
                              itemBuilder: (BuildContext context) {
                                return Choices.getAll.map((String choice) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Text(choice)
                                  );
                                }).toList();
                              },
                              child: Icon(Icons.more_vert, size: 30),
                              onSelected: choiceAction,
                            )
                          ),
                          SizedBox(height: 10),
                          // TODO: Ternary: If thing is active, green color and "Aktiv", else red color and "Inaktiv"
                          Text(
                              "Aktiv",
                              style: TextStyle(fontSize: 18, backgroundColor: zwapprGreen),
                          )
                        ]
                      )
                    )
                  ]
              )
            ),
          ]
        )
      )
    );
  }

  void choiceAction(String value) {
    switch (value) {
      case Choices.Edit:
        print(value);
        return null;
        // TODO: Edit item
      case Choices.Delete:
        print(value);
        return null;
      // TODO: Delete item
      default:
        print(value);
    }
  }
}

class Choices {
  static const String Edit = "Edit";
  static const String Delete = "Delete";

  static const List<String> getAll = <String>[
    Edit,
    Delete
  ];
}