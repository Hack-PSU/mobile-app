import 'package:flutter/material.dart';
import '../widgets/default_text.dart';
import '../models/event.dart';

// TODO: Actually work on displaying event details
class EventWorkshopCard extends StatelessWidget {
  final Event event;

  const EventWorkshopCard({@required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: () {
            debugPrint(event.eventDescription);
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 50,
            height: 80,
            child: Row(children: [
              Padding(padding: EdgeInsets.only(left: 8.0)),
              Icon(
                Icons.stars,
                size: 50,
                color: Colors.red,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(padding: EdgeInsets.only(top: 10.0)),
                DefaultText(
                  event.locationName.contains('zoom')
                      ? "Zoom"
                      : event.locationName,
                  fontLevel: TextLevel.overline,
                ),
                DefaultText(
                  event.eventTitle,
                  fontLevel: TextLevel.sub1,
                )
              ]),
              // TODO: add heart/starred function
              // Container(
              //     padding: EdgeInsets.only(left: 120),
              //     child: IconButton(
              //       onPressed: () {
              //         event.starred = !event.starred;
              //       },
              //       icon: event.starred
              //           ? Icon(Icons.favorite, color: Colors.red)
              //           : Icon(
              //               Icons.favorite_border,
              //             ),
              //       iconSize: 30,
              //       splashRadius: 22,
              //     )),
            ]),
          ),
        ));
  }
}
