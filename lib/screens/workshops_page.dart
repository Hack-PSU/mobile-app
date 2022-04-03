import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/favorites/favorites_state.dart';
import '../cubit/event_cubit.dart';
import '../cubit/workshop_cubit.dart';
import '../models/event.dart';
import '../widgets/agenda_view.dart';
import '../widgets/default_text.dart';
import '../widgets/event_card_list.dart';
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
    final favoritesBloc = context.read<FavoritesBloc>();

    return BlocBuilder<WorkshopCubit, List<Event>>(
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
              labels: const ["Saturday", "Sunday"],
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
}
