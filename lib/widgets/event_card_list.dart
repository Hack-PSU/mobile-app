import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/favorites/favorites_event.dart';
import '../bloc/favorites/favorites_state.dart';
import '../card_items/event_workshop_card.dart';
import '../models/event.dart';

class EventCardList extends StatelessWidget {
  const EventCardList({
    Key key,
    @required this.bloc,
    @required this.events,
  }) : super(key: key);

  final FavoritesBloc bloc;
  final List<Event> events;

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
                onAddFavorite: (Event event) {
                  bloc.add(AddFavoritesItem(event));
                },
                onRemoveFavorite: (Event event) {
                  bloc.add(RemoveFavoritesItem(event));
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
