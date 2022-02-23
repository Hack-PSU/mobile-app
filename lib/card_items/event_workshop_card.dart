import 'package:flutter/material.dart';
import '../widgets/default_text.dart';
import '../models/event.dart';
import '../data/api.dart';

// TODO: Actually work on displaying event details
class EventWorkshopCard extends StatelessWidget {
  bool favorite = false;
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: () {
            debugPrint("Description");
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 50,
            height: 80,
            child: Row(children: [
              Padding(padding: EdgeInsets.only(left: 8)),
              Icon(
                Icons.stars,
                size: 50,
                color: Colors.red,
              ),
              Column(children: [
                Padding(padding: EdgeInsets.only(top: 15, left: 100)),
                Text(
                  "eventLocation",
                ),
                Text("eventTitle")
              ]),
              Container(
                  padding: EdgeInsets.only(left: 150),
                  child: IconButton(
                    onPressed: () {
                      favorite = !favorite;
                    },
                    icon: favorite
                        ? Icon(Icons.favorite, color: Colors.red)
                        : Icon(
                            Icons.favorite_border,
                          ),
                    iconSize: 30,
                    splashRadius: 22,
                  )),
            ]),
          ),
        ));
  }
}
