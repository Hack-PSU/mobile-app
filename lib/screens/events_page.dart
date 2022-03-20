import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/favorites/favorites_event.dart';
import '../cubit/event_cubit.dart';
import '../cubit/favorites_cubit.dart';
import '../models/event.dart';
import '../widgets/agenda_view.dart';
import '../widgets/button.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, List<Event>>(
      builder: (context, events) {
        return BlocBuilder<FavoritesCubit, List<String>>(
          builder: (context, favorites) {
            debugPrint(favorites.toString());
            if (events == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final data = groupBy<Event, String>(events, _groupEvents);

            return AgendaView<Event>(
              labels: const ["Friday", "Saturday", "Sunday"],
              data: data,
              groupElement: _groupElement,
              renderItems: (items) => _showEvent(
                  context, context.read<FavoritesCubit>().getFavorite, events),
            );
          },
        );
      },
    );
  }

  Widget _showEvent(
      BuildContext context, Function(Event) isFavorite, List<Event> events) {
    // TODO -- return event_repo_card here
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: [
          ...events.map(
            (event) => Column(
              children: [
                DefaultText(
                  event.uid,
                  textLevel: TextLevel.body1,
                  fontSize: 16,
                  color: isFavorite(event) == true ? Colors.red : Colors.black,
                ),
                Button(
                  variant: ButtonVariant.ElevatedButton,
                  onPressed: () =>
                      context.read<FavoritesCubit>().addFavorite(event),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
