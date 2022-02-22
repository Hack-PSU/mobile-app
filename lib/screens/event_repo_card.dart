// import 'package:flutter/material.dart';
// import 'package:hackpsu/data/event_repository.dart';
// import '../models/event.dart';
// import '../data/api.dart';
//
// // TODO: Actually work on displaying event details
// class EventWorkshopCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Event>>(
//       future: Api.getEvents(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Text(snapshot.data[0].eventTitle);
//         } else if (snapshot.hasError) {
//           return Text('${snapshot.error}');
//         }
//
//         return const CircularProgressIndicator();
//       },
//     );
//   }
// }
