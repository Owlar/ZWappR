import 'package:flutter/material.dart';
import 'package:zwappr/features/things/models/thing_model.dart';

Card buildOwnThingCard(ThingModel thing, BuildContext context) {
  return Card(
      child: Container(
        width: 120,
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(thing.imageUrl),
            ),
        ),
      )
  );
}