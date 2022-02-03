import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackpsu/utils/cubits/event_cubit.dart';
import 'package:hackpsu/widgets/bottom_navigation/cubit.dart';
import 'package:hackpsu/widgets/bottom_navigation/main.dart';
import 'package:hackpsu/widgets/default_text.dart';
import 'package:hackpsu/widgets/screen.dart';
import 'package:provider/provider.dart';

import '../card_items/event_workshop_card.dart';
import '../data/authentication_service.dart';
import '../data/api.dart';
import '../models/event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, List<Event>>(
      builder: (context, events) {
        context.read<EventCubit>().getEvents();

        if (events == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: events
                .map((e) => DefaultText(
                      e.eventTitle,
                      fontSize: 14,
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
