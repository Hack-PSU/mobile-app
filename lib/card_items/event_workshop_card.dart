import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/event.dart';
import '../widgets/default_text.dart';

class EventWorkshopCard extends StatelessWidget {
  final Event event;

  const EventWorkshopCard({@required this.event});

  @override
  Widget build(BuildContext context) {
    String parseLocation(String locationName) {
      if (locationName.contains('zoom')) {
        return "Zoom";
      } else if (locationName.contains('youtube') ||
          locationName.contains('youtu.be')) {
        return "Youtube";
      } else {
        return locationName;
      }
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              // TODO: add content and formatting
              return Container(
                height: 300,
              );
            },
          );
        },
        child: SizedBox(
          height: 80,
          child: Row(children: [
            const Padding(padding: EdgeInsets.only(left: 10.0)),
            if (event.eventIcon != null)
              CircleAvatar(
                  radius: 25, backgroundImage: NetworkImage(event.eventIcon)),
            const Padding(padding: EdgeInsets.only(right: 10.0)),

            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultText(
                      parseLocation(event.locationName),
                      color: const Color(0x99000000),
                      fontLevel: TextLevel.overline,
                    ),
                    DefaultText(
                      event.eventTitle,
                      fontLevel: TextLevel.sub1,
                    ),
                    if (event.wsPresenterNames == null)
                      Center(
                          child: DefaultText('• • •',
                              color: const Color(0x57000000))),
                    if (event.wsPresenterNames != null)
                      DefaultText(event.wsPresenterNames ?? '',
                          color: const Color(0xFF6A85B9),
                          fontLevel: TextLevel.body2)
                  ]),
            ),
            // TODO: add the change in event.starred function
            SizedBox(
              child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    iconSize: 30,
                    splashRadius: 20.0,
                  )),
            ),
            const Padding(padding: EdgeInsets.only(right: 15.0))
          ]),
        ),
      ),
    );
  }
}
