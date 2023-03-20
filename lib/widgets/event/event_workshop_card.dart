import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../common/api/event.dart';
import '../../common/bloc/favorites/favorites_bloc.dart';
import '../../common/bloc/favorites/favorites_event.dart';
import '../../common/bloc/favorites/favorites_state.dart';
import '../../styles/theme_colors.dart';
import '../default_text.dart';
import '../render_html.dart';

class EventWorkshopCard extends StatelessWidget {
  const EventWorkshopCard({
    Key? key,
    required this.event,
    required this.onAddFavorite,
    required this.onRemoveFavorite,
  }) : super(key: key);

  final Event event;
  final Function(Event) onAddFavorite;
  final Function(Event) onRemoveFavorite;

  void _onToggleFavorites(bool isFavorite) {
    if (isFavorite) {
      onRemoveFavorite(event);
    } else {
      onAddFavorite(event);
    }
  }

  bool _buildWhen(FavoritesState previous, FavoritesState current) {
    if (previous.items != null && current.items != null) {
      return current.items != previous.items ||
          previous.status != current.status;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    String parseLocation(String? locationName) {
      if (locationName != null) {
        if (locationName.contains('zoom')) {
          return "Zoom";
        } else if (locationName.contains('youtube') ||
            locationName.contains('youtu.be')) {
          return "Youtube";
        } else {
          return locationName;
        }
      }
      return "";
    }

    return BlocBuilder<FavoritesBloc, FavoritesState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: InkWell(
            onTap: () {
              _BottomSheet.showModal(context, event, _buildWhen);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Padding(padding: EdgeInsets.only(right: 10.0)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultText(
                          parseLocation(event.location?.name!),
                          color: const Color(0x99000000),
                          textLevel: TextLevel.overline,
                        ),
                        DefaultText(
                          event.name!,
                          textLevel: TextLevel.sub1,
                        ),
                        if (event.wsPresenterNames == null)
                          Center(
                            child: DefaultText(
                              '• • •',
                              color: const Color(0x57000000),
                            ),
                          ),
                        if (event.wsPresenterNames != null)
                          DefaultText(
                            event.wsPresenterNames ?? '',
                            color: ThemeColors.HackyBlue,
                            textLevel: TextLevel.body2,
                          )
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          _onToggleFavorites(state.isFavorite(event));
                        },
                        icon: _FavoritesIcon(
                          isFavorite: state.isFavorite(event),
                        ),
                        iconSize: 30,
                        splashRadius: 20.0,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 10.0))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FavoritesIcon extends StatelessWidget {
  const _FavoritesIcon({
    required this.isFavorite,
  });

  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isFavorite ? Icons.favorite : Icons.favorite_outline,
      color: ThemeColors.StadiumOrange,
    );
  }
}

class _BottomSheet {
  static void showModal(
    BuildContext context,
    Event event,
    bool Function(FavoritesState, FavoritesState) buildWhen,
  ) {
    final String formatStartTime = DateFormat.jm().format(event.startTime);
    final String formatEndTime = DateFormat.jm().format(event.endTime);

    Widget resolveIcon(Event event) {
      if (event.icon == null) {
        switch (event.type!) {
          case EventType.ACTIVITY:
            return const Icon(
              Icons.event_available,
              size: 40,
            );
          case EventType.FOOD:
            return const Icon(
              Icons.fastfood,
              size: 40,
            );
          case EventType.WORKSHOP:
            return const Icon(
              Icons.co_present,
              size: 40,
            );
          case EventType.CHECKIN:
            return const Icon(
              Icons.error,
              size: 40,
            );
        }
      } else {
        if (event.icon!.endsWith(".svg")) {
          return SizedBox(
            width: 50,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: SvgPicture.network(
                event.icon!,
                fit: BoxFit.cover,
              ),
            ),
          );
        } else {
          return CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(event.icon!),
          );
        }
      }
    }

    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (BuildContext context) {
        // Icon getEventIcon(EventType? eventType) {
        //   if (eventType == EventType.ACTIVITY) {
        //     return const Icon(
        //       Icons.event_available,
        //       size: 40,
        //     );
        //   }
        //   if (eventType == EventType.FOOD) {
        //     return const Icon(
        //       Icons.fastfood,
        //       size: 40,
        //     );
        //   }
        //   if (eventType == EventType.WORKSHOP) {
        //     return const Icon(
        //       Icons.co_present,
        //       size: 40,
        //     );
        //   }
        //   return const Icon(
        //     Icons.error,
        //     size: 40,
        //   );
        // }

        return BlocBuilder<FavoritesBloc, FavoritesState>(
          buildWhen: buildWhen,
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0, right: 10.0),
                          child: resolveIcon(event),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                event.name!,
                                textLevel: TextLevel.sub1,
                                maxLines: 10,
                              ),
                              if (event.wsPresenterNames != null)
                                DefaultText(
                                  event.wsPresenterNames ?? '',
                                  color: ThemeColors.HackyBlue,
                                  textLevel: TextLevel.body2,
                                ),
                              DefaultText(
                                '$formatStartTime - $formatEndTime',
                                textLevel: TextLevel.sub1,
                                weight: FontWeight.w500,
                                color: ThemeColors.HackyBlue,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                if (state.isFavorite(event)) {
                                  context
                                      .read<FavoritesBloc>()
                                      .add(RemoveFavoritesItem(event));
                                } else {
                                  context
                                      .read<FavoritesBloc>()
                                      .add(AddFavoritesItem(event));
                                }
                              },
                              icon: _FavoritesIcon(
                                isFavorite: state.isFavorite(event),
                              ),
                              iconSize: 30,
                              splashRadius: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Chip(
                      avatar: const Icon(Icons.location_on_rounded),
                      label: DefaultText(event.location?.name ?? ""),
                    ),
                    if (event.description != null)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(top: 10.0),
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          top: 5.0,
                          bottom: 10.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: Colors.black12,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultText(
                              'Description',
                              textLevel: TextLevel.body1,
                            ),
                            RenderHtml(
                              event.description!,
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 80.0),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
