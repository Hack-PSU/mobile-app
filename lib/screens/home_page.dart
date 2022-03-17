import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackpsu/card_items/homepage_header.dart';
import 'package:provider/provider.dart';

import '../card_items/countdown_timer_card.dart';
import '../card_items/pin_card.dart';
import '../cubit/event_cubit.dart';
import '../cubit/registration_cubit.dart';
import '../data/authentication_repository.dart';
import '../models/event.dart';
import '../models/registration.dart';
import '../widgets/button.dart';
import '../widgets/default_text.dart';

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

            return Column(
              children: [
                AppBar(
                  backgroundColor: Colors.white,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(radius: 40),
                    )
                  ],
                  flexibleSpace: SafeArea(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              color: Color(0xffF5F5F5),
                              image: DecorationImage(
                                image: AssetImage('assets/images/Logo.png'),
                              ),
                            ),
                          ),
                        ),
                      )
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HomepageHeader(),
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
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
