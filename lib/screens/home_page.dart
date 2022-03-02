import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../card_items/countdown_timer_card.dart';
import '../card_items/pin_card.dart';
import '../cubit/event_cubit.dart';
import '../cubit/registration_cubit.dart';
import '../data/authentication_repository.dart';
import '../models/event.dart';
import '../models/registration.dart';
import '../widgets/button.dart';
import '../widgets/default_text.dart';
import '../widgets/screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      withBottomNavigation: true,
      body: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, List<Event>>(
      builder: (context, events) {
        return BlocBuilder<RegistrationCubit, List<Registration>>(
          builder: (context, registrations) {
            // fetch data first
            context.read<EventCubit>().getEvents();
            context.read<RegistrationCubit>().getUserInfo();

            // while loading show the progress indicator
            if (events == null || registrations == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CountdownTimerCard(),
                  // registrations is passed in from here
                  UserPinCard(registrations),
                  ...events
                      .map((e) => DefaultText(
                            e.eventTitle ?? "Event",
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
      },
    );
  }
}
