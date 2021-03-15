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

  Future<List<ThingModel>> _getThingsFromService() async {
    final List<ThingModel> _thingsFromService = (await _thingsService.getAll());
    return _thingsFromService;
  }

  @override
  void initState() {
    _getThingsFromService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getThingsFromService(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
                padding: const EdgeInsets.all(14.0),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final thing = snapshot.data[index];
                  return Observer(
                      builder: (_) => ThingListItem(thing: thing)
                  );
                }
            );
          }
        }
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewThingPage())
          );
          // Test objects
          final ThingModel watch = ThingModel(
              title: "Klokke Rolex",
              description: "Pent brukt Rolex Submariner",
              numberOfLikes: 8,
              imageUrl: "https://images.unsplash.com/photo-1611243705491-71487c2ed137?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80"
          );
          final ThingModel clothes = ThingModel(
              title: "Diverse klær",
              description: "Diverse klær selges pga. oppgradering av garderoben. Kom med bud!",
              numberOfLikes: 32,
              imageUrl: "https://images.unsplash.com/photo-1495121605193-b116b5b9c5fe?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=634&q=80"
          );

          // 1. Creating
          _thingsService.create(watch);
          _thingsService.create(clothes);

          // 2. Listing
          List<ThingModel> things = List();
          things = await _thingsService.getAll();
          print("Should print all things below:");
          print(things);


        },
        label: Text("Ny ting"),
        icon: Icon(Icons.add),
      )

    );
  }

}