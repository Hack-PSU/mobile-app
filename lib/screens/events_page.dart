// TODO -- use MaterialPageRoute to declaratively change the route based on
// TODO -- BlocConsumer

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackpsu/card_items/event_workshop_card.dart';
import '../cubit/event_cubit.dart';

import '../models/event.dart';
import '../widgets/default_text.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, List<Event>>(
      builder: (context, events) {
        context.read<EventCubit>().getEvents();
        if (events == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...events.map((e) => EventWorkshopCard(event: e)).toList()
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget _showEvent(Event event) {
  //   // TODO -- return event_repo_card here
  //   return Container(
  //     decoration: const BoxDecoration(
  //       borderRadius: BorderRadius.all(Radius.circular(5)),
  //     ),
  //     child: Column(
  //       children: [
  //         DefaultText(
  //           event.eventTitle,
  //           fontLevel: TextLevel.body1,
  //           fontSize: 16,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
