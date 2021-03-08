import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:zwappr/features/things/ui/widgets/thing_list_item.dart';

import 'new_thing_page.dart';

class ThingsPage extends StatefulWidget {
  @override
  _ThingsPageState createState() => _ThingsPageState();
}

class _ThingsPageState extends State<ThingsPage> {
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
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewThingPage())
        ),
        label: Text("Ny ting"),
        icon: Icon(Icons.add),
      )

    );
  }

}