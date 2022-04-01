import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/favorites/favorites_event.dart';
import '../cubit/event_cubit.dart';
import '../models/event.dart';
import '../styles/theme_colors.dart';
import '../widgets/default_text.dart';
import 'event_workshop_card.dart';

class NextEventCard extends StatelessWidget {
  const NextEventCard({
    Key key,
  }) : super(key: key);

  Event getNextEvent(List<Event> events) {
    for (var i=0; i < events.length; i++) {
      final int timeDifference =
          events[i].eventStartTime.millisecondsSinceEpoch
              + const Duration(minutes: 15).inMilliseconds // Want to show next event up until 15 minutes after the start time
              - DateTime.now().millisecondsSinceEpoch;
      if (timeDifference >= 0) {
        return events[i];
      }
    }
    return null;
  }

  String _formatTime(int time) {
    final DateFormat formatter = DateFormat("h:mm a");
    return formatter
        .format(DateTime.fromMillisecondsSinceEpoch(time))
        .toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, List<Event>>(
      builder: (context, events) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: Colors.white),
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0),
          width: MediaQuery.of(context).size.width * 0.95,
          alignment: Alignment.centerLeft,
          child: getNextEvent(events) != null ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DefaultText(
                    "Next Event @ ",
                    textLevel: TextLevel.h4,
                  ),
                  DefaultText(
                    _formatTime(getNextEvent(events).eventStartTime.millisecondsSinceEpoch),
                    textLevel: TextLevel.h4,
                    weight: FontWeight.bold,
                    color: ThemeColors.HackyBlue,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              DefaultText(
                DateFormat('EEEE').format(getNextEvent(events).eventStartTime),
                textLevel: TextLevel.sub1,
              ),
              EventWorkshopCard(
                event: getNextEvent(events),
                onAddFavorite: (Event event) {
                  context.read<FavoritesBloc>().add(AddFavoritesItem(event));
                },
                onRemoveFavorite: (Event event) {
                  context
                      .read<FavoritesBloc>()
                      .add(RemoveFavoritesItem(event));
                },
              ),
            ],
          ) :
          DefaultText(
          "No upcoming events",
          textLevel: TextLevel.h4,
        ),
        );
      },
    );
  }
}
