import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../common/api/event.dart';
import '../../common/bloc/favorites/favorites_bloc.dart';
import '../../common/bloc/favorites/favorites_event.dart';
import '../../common/bloc/navigation/bottom_navigation_bloc.dart';
import '../../common/bloc/navigation/bottom_navigation_event.dart';
import '../../common/bloc/navigation/bottom_navigation_state.dart';
import '../../styles/theme_colors.dart';
import '../../widgets/custom_icons.dart';
import '../../widgets/default_text.dart';
import '../../widgets/event/event_workshop_card.dart';
import 'upcoming_event_cubit.dart';

class UpcomingEventCardContainer extends StatelessWidget {
  const UpcomingEventCardContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      width: MediaQuery.of(context).size.width * 0.95,
      alignment: Alignment.centerLeft,
      child: child,
    );
  }
}

class UpcomingEventCard extends StatelessWidget {
  const UpcomingEventCard({
    Key? key,
    required this.type,
    required this.events,
  }) : super(key: key);

  final EventType type;
  final List<Event> events;

  String _formatTime(int time) {
    final DateFormat formatter = DateFormat("h:mm a");
    return formatter
        .format(DateTime.fromMillisecondsSinceEpoch(time))
        .toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UpcomingEventCubit>(
      create: (_) => UpcomingEventCubit(events),
      child: BlocBuilder<UpcomingEventCubit, UpcomingEventCubitState>(
        buildWhen: (prev, curr) =>
            prev.upcomingEvents != null &&
            curr.upcomingEvents != null &&
            prev.upcomingEvents != curr.upcomingEvents,
        builder: (context, state) {
          if (state.upcomingEvents == null || state.upcomingEvents!.isEmpty) {
            return UpcomingEventCardContainer(
              child: DefaultText(
                "No upcoming ${type == EventType.ACTIVITY ? "events" : "workshops"}",
                textLevel: TextLevel.h4,
              ),
            );
          }

          return UpcomingEventCardContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultText(
                      "Next ${type == EventType.ACTIVITY ? "Event" : "Workshop"}",
                      textLevel: TextLevel.h4,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (type == EventType.WORKSHOP) {
                          context
                              .read<BottomNavigationBloc>()
                              .add(const RouteChanged(Routes.Workshops));
                        } else {
                          context
                              .read<BottomNavigationBloc>()
                              .add(const RouteChanged(Routes.Events));
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DefaultText(
                            "Show More",
                            textLevel: TextLevel.body1,
                            color: ThemeColors.HackyBlue,
                            height: 1.0,
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          const Icon(
                            CustomIcons.arrowForward,
                            size: 20.0,
                            color: ThemeColors.HackyBlue,
                          ),
                        ],
                      ),
                    )
                    // RichText(
                    //   text: TextSpan(
                    //     // // recognizer: TapGestureRecognizer()
                    //     // //   ..onTap = () {
                    //     //
                    //     //   },
                    //     children: [
                    //       WidgetSpan(
                    //         child: GestureDetector(
                    //             onTap: () {
                    //
                    //             },
                    //             child: TextSpan(children: [
                    //
                    //             ])),
                    //       ),
                    //       const TextSpan(
                    //           text: "Show More",
                    //           style: TextStyle(color: Colors.black)),
                    //     ],
                    //   ),
                    // ),
                    // DefaultText(
                    //   _formatTime(
                    //     state.upcomingEvents!.first.eventStartTime
                    //         .millisecondsSinceEpoch,
                    //   ),
                    //   textLevel: TextLevel.h4,
                    //   weight: FontWeight.bold,
                    //   color: ThemeColors.HackyBlue,
                    //   maxLines: 2,
                    //   textAlign: TextAlign.left,
                    // ),
                  ],
                ),
                DefaultText(
                  DateFormat("EEEE").format(
                    state.upcomingEvents!.first.startTime,
                  ),
                  textLevel: TextLevel.h4,
                ),
                ...state.upcomingEvents!.map(
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
