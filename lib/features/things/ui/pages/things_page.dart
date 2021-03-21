import 'dart:async';

import 'package:flutter/material.dart';
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

  Future<List<ThingModel>> _getThingsFromService() async {
    final List<ThingModel> _thingsFromService = (await _thingsService.getAll());
    return _thingsFromService;
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {
      _getThingsFromService();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getThingsFromService(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator()
            );
          } else {
            return ListView.builder(
                padding: const EdgeInsets.all(14.0),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final thing = snapshot.data[index];
                  return ThingListItem(thing: thing);
                }
            );
          }
        }
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Route route = MaterialPageRoute(builder: (context) => NewThingPage());
          Navigator.push(context, route).then(onGoBack);
        },
        label: Text("Ny ting"),
        icon: Icon(Icons.add),
      )
    );
  }

}