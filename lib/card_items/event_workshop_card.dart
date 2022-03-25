import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
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

    final String formatStartTime = DateFormat.jm().format(event.eventStartTime);
    final String formatEndTime = DateFormat.jm().format(event.eventEndTime);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.all(15.0),
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (event.eventIcon != null)
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, right: 10.0),
                              child: event.eventIcon != ''
                                  ? CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          NetworkImage(event.eventIcon))
                                  : const Icon(
                                      Icons.event_available,
                                      size: 50,
                                    ),
                            ),

                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DefaultText(
                                    event.eventTitle,
                                    textLevel: TextLevel.h4,
                                  ),
                                  if (event.wsPresenterNames != null)
                                    DefaultText(event.wsPresenterNames ?? '',
                                        color: const Color(0xFF6A85B9),
                                        textLevel: TextLevel.body2),
                                  Text(
                                    '$formatStartTime - $formatEndTime',
                                    style: const TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF6A85B9)),
                                  ),
                                ]),
                          ),
                          // TODO: add the change in event.starred function
                          SizedBox(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.favorite,
                                    color: Colors.red),
                                iconSize: 30,
                                splashRadius: 20.0,
                              ),
                            ),
                          ),
                        ]),
                    Chip(
                      avatar: const Icon(Icons.location_on_rounded),
                      label: DefaultText(event.locationName),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 10.0),
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 5.0, bottom: 10.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: Colors.black12,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultText(
                              'Description',
                              textLevel: TextLevel.body1,
                            ),
                            DefaultText(
                              event.eventDescription,
                              textLevel: TextLevel.body2,
                            ),
                          ]),
                    )
                  ],
                ),
              );
            },
          );
        },
        child: SizedBox(
          height: 80,
          child: Row(children: [
            if (event.eventIcon != null)
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: event.eventIcon != ''
                    ? CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(event.eventIcon))
                    : const Icon(
                        Icons.event_available,
                        size: 50,
                      ),
              ),
            const Padding(padding: EdgeInsets.only(right: 10.0)),

            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultText(
                      parseLocation(event.locationName),
                      color: const Color(0x99000000),
                      textLevel: TextLevel.overline,
                    ),
                    DefaultText(
                      event.eventTitle,
                      textLevel: TextLevel.sub1,
                    ),
                    if (event.wsPresenterNames == null)
                      Center(
                          child: DefaultText('• • •',
                              color: const Color(0x57000000))),
                    if (event.wsPresenterNames != null)
                      DefaultText(event.wsPresenterNames ?? '',
                          color: const Color(0xFF6A85B9),
                          textLevel: TextLevel.body2)
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
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(right: 10.0))
          ]),
        ),
      ),
    );
  }
}
