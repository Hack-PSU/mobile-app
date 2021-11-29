import 'package:flutter/material.dart';
import 'package:hackpsu/models/event.dart';
import 'package:hackpsu/data/api.dart';

class EventWorkshopCard extends StatelessWidget {
  final Api data = Api();
  // final String eventName;

  // const EventWorkshopCard({
  //   @required this.eventName,
  // });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Event>(
      future: data.getEvents(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.eventTitle);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
