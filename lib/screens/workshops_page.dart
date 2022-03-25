import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../card_items/event_workshop_card.dart';
import '../cubit/event_cubit.dart';
import '../models/event.dart';
import '../widgets/agenda_view.dart';
import '../widgets/default_text.dart';
import '../widgets/screen.dart';

class WorkshopsPage extends StatelessWidget {
  const WorkshopsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      withBottomNavigation: true,
      header: ScreenHeader.text("Workshops"),
      body: const WorkshopsScreen(),
      contentBackgroundColor: Colors.white,
    );
  }
}

class WorkshopsScreen extends StatelessWidget {
  const WorkshopsScreen({Key key}) : super(key: key);

  String _groupEvents(Event item) {
    final DateFormat formatter = DateFormat("EEEE");
    return formatter.format(item.eventStartTime);
  }

  int _groupElement(Event item) {
    return item.eventStartTime.millisecondsSinceEpoch;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, List<Event>>(
      builder: (context, events) {
        if (events == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final data = groupBy<Event, String>(events, _groupEvents);

        return AgendaView<Event>(
          data: data,
          labels: const ["Friday", "Saturday", "Sunday"],
          groupElement: _groupElement,
          renderItems: (el) => Column(
            children: el
                .map(
                  (e) => EventWorkshopCard(event: e),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
