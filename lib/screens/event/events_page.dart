import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../common/api/event.dart';
import '../../common/bloc/favorites/favorites_bloc.dart';
import '../../common/bloc/favorites/favorites_state.dart';
import '../../widgets/event_card_list.dart';
import '../../widgets/screen/screen.dart';
import '../../widgets/view/agenda_view.dart';
import 'events_page_cubit.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

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
  const EventsScreen({Key? key}) : super(key: key);

  String _groupEvents(Event item) {
    return DateFormat("EEEE").format(item.startTime);
  }

  int _groupElement(Event item) {
    return item.startTime.millisecondsSinceEpoch;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsPageCubit, EventsPageCubitState>(
      // buildWhen: (previous, current) {
      //   if (previous.favorites != null && current.favorites != null) {
      //     return previous.favorites != current.favorites ||
      //         previous.isFavoritesEnabled != current.isFavoritesEnabled;
      //   }
      //   return false;
      // },
      builder: (context, state) {
        if (state.status == PageStatus.idle) {
          context.read<EventsPageCubit>().init();
        }
        if (state.events != null) {
          final data = groupBy<Event, String>(state.events ?? [], _groupEvents);

          return BlocListener<FavoritesBloc, FavoritesState>(
            listener: (listenerContext, listenerState) {
              if (listenerState.status == FavoritesStatus.enabled) {
                context.read<EventsPageCubit>().toggleFavorites(true);
              } else {
                context.read<EventsPageCubit>().toggleFavorites(false);
              }

              if (listenerState.items != state.favorites) {
                context
                    .read<EventsPageCubit>()
                    .setFavorites(listenerState.items);
              }
            },
            child: AgendaView(
              data: data,
              labels: const ["Saturday", "Sunday"],
              groupElement: _groupElement,
              favorites: state.favorites,
              favoritesEnabled: state.isFavoritesEnabled ?? false,
              renderItems: (el) => EventCardList(
                events: el,
                onAddFavorite: context.read<EventsPageCubit>().markFavorite,
                onRemoveFavorite:
                    context.read<EventsPageCubit>().unmarkFavorite,
              ),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
