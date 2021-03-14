import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:uuid/uuid.dart';
import 'package:zwappr/features/feed/data/things.dart';
import 'package:zwappr/features/feed/models/thing.dart';
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
  // Thing objects in list are borrowed from feed models directory
  final List<Thing> things = mockThings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) => ListView.builder(
          padding: const EdgeInsets.all(14.0),
          itemCount: things.length,
          itemBuilder: (BuildContext context, int index) {
            final thing = things[index];
            return Observer(
              builder: (_) => ThingListItem(thing: thing)
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
          // TESTING
          var uid = Uuid();
          final ThingModel thing = ThingModel(title: "test", description: "testesen", uid: uid.v4());
          final ThingModel shoes = ThingModel(title: "Selskapsko", description: "Blanke og nye sko i stor størrelse", uid: uid.v4());

          // 1. Creating
          _thingsService.create(thing);
          _thingsService.create(shoes);

          // 2. Listing
          List<ThingModel> things = List();
          things = await _thingsService.getAll();
          print(things);


        },
        label: Text("Ny ting"),
        icon: Icon(Icons.add),
      )

    );
  }

}