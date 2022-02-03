// TODO -- use MaterialPageRoute to declaratively change the route based on
// TODO -- BlocConsumer

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackpsu/data/event_repository.dart';
import 'package:hackpsu/models/event.dart';
import 'package:hackpsu/utils/cubits/event_cubit.dart';
import 'package:hackpsu/widgets/screen.dart';
import 'package:hackpsu/widgets/default_text.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, List<Event>>(
      builder: (context, events) {
        context.read<EventCubit>().getEvents();

        if (events == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: events.map((e) => _showEvent(e)).toList(),
          ),
        );
      },
    );
  }

  Widget _showEvent(Event event) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: [
          DefaultText(
            event.locationName,
            fontLevel: FontLevel.body1,
            fontSize: 16,
          ),
        ],
      ),
    );
  }
}
