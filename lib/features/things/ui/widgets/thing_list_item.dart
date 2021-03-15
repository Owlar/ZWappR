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
      margin: EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget> [
            Container(
              child: Row(
                  children: <Widget> [
                    Expanded(
                      flex: 2,
                      child: thing.imageUrl == null ? Image.asset("assets/images/loading_item_list.jpg") : Image.network(thing.imageUrl),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                              thing.title,
                              overflow: TextOverflow.ellipsis
                          ),
                          SizedBox(height: 10),
                          Text(
                              thing.description,
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
                              child: Icon(Icons.more_vert),
                              onSelected: choiceAction,
                            )
                          ),
                          SizedBox(height: 10),
                          // TODO: Ternary: If thing is active, green color and "Aktiv", else red color and "Inaktiv"
                          Text(
                              "Aktiv",
                              style: TextStyle(backgroundColor: zwapprGreen),
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