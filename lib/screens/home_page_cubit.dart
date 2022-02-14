import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackpsu/data/authentication_repository.dart';
import 'package:hackpsu/utils/cubits/event_cubit.dart';
import 'package:hackpsu/widgets/button.dart';
import 'package:hackpsu/widgets/default_text.dart';
import 'package:provider/provider.dart';
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
            children: [
              ...events
                  .map((e) => DefaultText(
                        e.eventTitle,
                        fontSize: 14,
                      ))
                  .toList(),
              Button(
                variant: ButtonVariant.TextButton,
                onPressed: () {
                  context.read<AuthenticationRepository>().signOut();
                },
                child: DefaultText(
                  "Log out",
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
