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
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
            builder: (BuildContext context) {
              // TODO: add content and formatting
              return Container(
                padding: const EdgeInsets.all(15.0),
                height: 300,
                child: Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (event.eventIcon != null)
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, right: 10.0),
                              child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      NetworkImage(event.eventIcon)),
                            ),

                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DefaultText(
                                    event.eventTitle,
                                    fontLevel: TextLevel.h4,
                                  ),
                                  if (event.wsPresenterNames != null)
                                    DefaultText(event.wsPresenterNames ?? '',
                                        color: const Color(0xFF6A85B9),
                                        fontLevel: TextLevel.body2),
                                  DefaultText("6:00pm - 7:00pm",
                                      fontLevel: TextLevel.body2,
                                      color: const Color(0xFF6A85B9)),
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
                    DefaultText(event.locationName),
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
                              fontLevel: TextLevel.body1,
                            ),
                            DefaultText(
                              event.eventDescription,
                              fontLevel: TextLevel.body2,
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
                  child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(event.eventIcon))),
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
