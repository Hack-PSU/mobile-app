import 'package:flutter/material.dart';

import '../common/api/event.dart';
import 'event/event_workshop_card.dart';

class EventCardList extends StatelessWidget {
  const EventCardList({
    Key? key,
    required this.onAddFavorite,
    required this.onRemoveFavorite,
    required this.events,
  }) : super(key: key);

  final List<Event> events;
  final Function(Event) onAddFavorite;
  final Function(Event) onRemoveFavorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: events
            .map(
              (event) => EventWorkshopCard(
                event: event,
                onAddFavorite: onAddFavorite,
                onRemoveFavorite: onRemoveFavorite,
              ),
            )
            .toList(),
      ),
    );
  }
}
