import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackpsu/widgets/agenda.dart';

import '../cubit/event_cubit.dart';
import '../models/event.dart';
import '../widgets/default_text.dart';
import '../widgets/screen.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      withBottomNavigation: true,
      header: ScreenHeader.text("Events"),
      body: const EventsScreen(),
      safeAreaLeft: true,
      safeAreaRight: true,
    );
  }
}

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, List<Event>>(
      builder: (context, events) {
        // context.read<EventCubit>().getEvents();

        if (events == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Center(
          child: Agenda<Event>(
            orientation: Axis.horizontal,
            data: events,
            groupElement: (e) => e.eventStartTime.millisecondsSinceEpoch,
            renderItems: (item) => _showEvent(item),
          ),
        );
      },
    );
  }

  Widget _showEvent(List<Event> events) {
    // TODO -- return event_repo_card here
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: [
          ...events.map(
            (event) => DefaultText(
              event.locationName,
              textLevel: TextLevel.body1,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
