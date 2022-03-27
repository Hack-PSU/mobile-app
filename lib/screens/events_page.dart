import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackpsu/card_items/event_workshop_card.dart';
import '../cubit/event_cubit.dart';
import 'package:intl/intl.dart';

import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/favorites/favorites_event.dart';
import '../bloc/favorites/favorites_state.dart';
import '../cubit/event_cubit.dart';
import '../cubit/favorites_cubit.dart';
import '../models/event.dart';
import '../widgets/agenda_view.dart';
import '../widgets/button.dart';
import '../widgets/default_text.dart';
import '../widgets/event_card_list.dart';
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
      contentBackgroundColor: Colors.white,
    );
  }
}

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key key}) : super(key: key);

  String _groupEvents(Event item) {
    final DateFormat formatter = DateFormat("EEEE");
    return formatter.format(item.eventStartTime);
  }

  int _groupElement(Event item) {
    return item.eventStartTime.millisecondsSinceEpoch;
  }

  Map<String, List<Event>> _sortData(
      bool favoritesEnabled, Set<String> favorites, List<Event> events) {
    List<Event> newEvents;
    if (favoritesEnabled == true) {
      newEvents = events.where((e) => favorites.contains(e.uid)).toList();
    } else {
      newEvents = events;
    }
    return groupBy<Event, String>(newEvents, _groupEvents);
  }

  @override
  Widget build(BuildContext context) {
    final favoritesBloc = context.read<FavoritesBloc>();

    return BlocBuilder<EventCubit, List<Event>>(
      builder: (context, events) {
        return BlocBuilder<FavoritesBloc, FavoritesState>(
          buildWhen: (previous, current) {
            if (previous.items != null && current.items != null) {
              return previous.items != current.items ||
                  current.status != previous.status;
            }
            return false;
          },
          builder: (context, favorites) {
            if (events == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final data = groupBy<Event, String>(events, _groupEvents);

            return AgendaView(
              labels: const ["Friday", "Saturday", "Sunday"],
              favorites: favorites.items,
              favoritesEnabled: favorites.status == FavoritesStatus.enabled,
              data: data,
              groupElement: _groupElement,
              renderItems: (el) => EventCardList(
                bloc: favoritesBloc,
                events: el,
              ),
            );
          },
        );
      },
    );
  }

  Widget _showEvents(BuildContext context, List<Event> events) {
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
                    context.read<FavoritesBloc>().add(AddFavoritesItem(event));
                  },
                  onRemoveFavorite: (Event event) {
                    context
                        .read<FavoritesBloc>()
                        .add(RemoveFavoritesItem(event));
                  },
                ),
              )
              .toList()
          // ],
          ),
    );
  }

  // Widget _showEvent(
  //     BuildContext context, FavoritesState state, List<Event> events) {
  //   return Container(
  //     decoration: const BoxDecoration(
  //       borderRadius: BorderRadius.all(Radius.circular(5)),
  //     ),
  //     child: Column(
  //       children: [
  //         ...events.map(
  //           (event) => Column(
  //             children: [
  //               DefaultText(
  //                 event.uid,
  //                 textLevel: TextLevel.body1,
  //                 fontSize: 16,
  //                 color: state.isFavorite(event) ? Colors.red : Colors.black,
  //               ),
  //               Button(
  //                 variant: ButtonVariant.ElevatedButton,
  //                 onPressed: () => context
  //                     .read<FavoritesBloc>()
  //                     .add(AddFavoritesItem(event)),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
