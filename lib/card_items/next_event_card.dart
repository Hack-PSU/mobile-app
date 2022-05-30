import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/favorites/favorites_event.dart';
import '../cubit/next_event_cubit.dart';
import '../models/event.dart';
import '../models/next_event_state.dart';
import '../styles/theme_colors.dart';
import '../widgets/default_text.dart';
import 'event_workshop_card.dart';

enum NextEventType { EVENT, WORKSHOP }

class NextEventCard extends StatelessWidget {
  const NextEventCard({
    Key? key,
    required this.type,
    required this.events,
  }) : super(key: key);

  final NextEventType type;
  final List<Event> events;

  String _formatTime(int time) {
    final DateFormat formatter = DateFormat("h:mm a");
    return formatter
        .format(DateTime.fromMillisecondsSinceEpoch(time))
        .toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NextEventCubit>(
      create: (_) => NextEventCubit(events),
      child: BlocBuilder<NextEventCubit, NextEventState>(
        buildWhen: (previous, current) =>
            previous.nextEvents != null &&
            current.nextEvents != null &&
            previous.nextEvents != current.nextEvents,
        builder: (context, state) {
          if (state.nextEvents == null) {
            return DefaultText(
              "No upcoming ${type == NextEventType.EVENT ? "events" : "workshops"}",
              textLevel: TextLevel.h4,
            );
          }
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0),
            width: MediaQuery.of(context).size.width * 0.95,
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    DefaultText(
                      "Next ${type == NextEventType.EVENT ? "Event" : "Workshop"} @ ",
                      textLevel: TextLevel.h4,
                    ),
                    DefaultText(
                      _formatTime(
                        state.nextEvents!.first.eventStartTime
                            .millisecondsSinceEpoch,
                      ),
                      textLevel: TextLevel.h4,
                      weight: FontWeight.bold,
                      color: ThemeColors.HackyBlue,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                DefaultText(
                  DateFormat('EEEE')
                      .format(state.nextEvents!.first.eventStartTime),
                  textLevel: TextLevel.sub1,
                ),
                ...state.nextEvents!
                    .map(
                      (event) => EventWorkshopCard(
                        event: event,
                        onAddFavorite: (Event event) {
                          context
                              .read<FavoritesBloc>()
                              .add(AddFavoritesItem(event));
                        },
                        onRemoveFavorite: (Event event) {
                          context
                              .read<FavoritesBloc>()
                              .add(RemoveFavoritesItem(event));
                        },
                      ),
                    )
                    .toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
