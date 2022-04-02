import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/favorites/favorites_event.dart';
import '../bloc/favorites/favorites_state.dart';
import '../models/event.dart';
import '../styles/theme_colors.dart';
import '../widgets/default_text.dart';

class EventWorkshopCard extends StatelessWidget {
  const EventWorkshopCard({
    Key key,
    @required this.event,
    @required this.onAddFavorite,
    @required this.onRemoveFavorite,
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
    String parseLocation(String locationName) {
      if (locationName.contains('zoom')) {
        return "Zoom";
      } else if (locationName.contains('youtube') ||
          locationName.contains('youtu.be')) {
        return "Youtube";
      } else {
        return locationName;
      }
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
                  if (event.eventIcon != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(event.eventIcon),
                      ),
                    ),
                  const Padding(padding: EdgeInsets.only(right: 10.0)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultText(
                          parseLocation(event.locationName),
                          color: const Color(0x99000000),
                          textLevel: TextLevel.overline,
                        ),
                        DefaultText(
                          event.eventTitle,
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
    @required this.isFavorite,
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
  static void showModal(BuildContext context, Event event,
      bool Function(FavoritesState, FavoritesState) buildWhen) {
    final String formatStartTime = DateFormat.jm().format(event.eventStartTime);
    final String formatEndTime = DateFormat.jm().format(event.eventEndTime);

    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (BuildContext context) {
        return BlocBuilder<FavoritesBloc, FavoritesState>(
          buildWhen: buildWhen,
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(15.0),
              // height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (event.eventIcon != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0, right: 10.0),
                          child: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(event.eventIcon)),
                        ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultText(
                              event.eventTitle,
                              textLevel: TextLevel.overline,
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
                    label: DefaultText(event.locationName),
                  ),
                  if (event.eventDescription != null)
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
                          DefaultText(
                            event.eventDescription,
                            textLevel: TextLevel.body2,
                            maxLines: 10,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
