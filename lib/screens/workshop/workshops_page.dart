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
import 'workshops_page_cubit.dart';

class WorkshopsPage extends StatelessWidget {
  const WorkshopsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      withBottomNavigation: true,
      header: ScreenHeader.text("Worksohps"),
      body: const WorkshopsScreen(),
      contentBackgroundColor: Colors.white,
    );
  }
}

class WorkshopsScreen extends StatelessWidget {
  const WorkshopsScreen({Key? key}) : super(key: key);

  String _groupEvents(Event item) {
    return DateFormat("EEEE").format(item.eventStartTime);
  }

  int _groupElement(Event item) {
    return item.eventStartTime.millisecondsSinceEpoch;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkshopsPageCubit, WorkshopsPageCubitState>(
      builder: (context, state) {
        if (state.status == PageStatus.idle) {
          context.read<WorkshopsPageCubit>().init();
        }
        if (state.workshops != null) {
          final data = groupBy<Event, String>(
            state.workshops ?? [],
            _groupEvents,
          );
          return BlocListener<FavoritesBloc, FavoritesState>(
            listener: (listenerContext, listenerState) {
              print(listenerState.status);
              if (listenerState.status == FavoritesStatus.enabled) {
                context.read<WorkshopsPageCubit>().toggleFavorites(true);
              } else {
                context.read<WorkshopsPageCubit>().toggleFavorites(false);
              }
              if (listenerState.items != state.favorites) {
                context
                    .read<WorkshopsPageCubit>()
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
                onAddFavorite: context.read<WorkshopsPageCubit>().markFavorite,
                onRemoveFavorite:
                    context.read<WorkshopsPageCubit>().unmarkFavorite,
                events: el,
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
