import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:zwappr/features/things/models/thing_model.dart';
import 'package:zwappr/features/things/services/i_things_service.dart';
import 'package:zwappr/features/things/services/things_service.dart';
import 'package:zwappr/features/things/ui/widgets/thing_list_item.dart';

import 'new_thing_page.dart';

class ThingsPage extends StatefulWidget {
  @override
  _ThingsPageState createState() => _ThingsPageState();
}


class _ThingsPageState extends State<ThingsPage> {
  static final IThingsService _thingsService = ThingsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) => ListView.builder(
          padding: const EdgeInsets.all(14.0),
          // TODO: Set to length of items list
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Observer(
              builder: (_) => ThingListItem()
            );
          }
        ),

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewThingPage())
          );
          final ThingModel thing = ThingModel("testesen123123", "test", "testesen");
          _thingsService.create(thing);

        },
        label: Text("Ny ting"),
        icon: Icon(Icons.add),
      )

    );
  }

}