import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackpsu/card_items/countdown_timer_card.dart';
import 'package:hackpsu/card_items/event_workshop_card.dart';
import 'package:hackpsu/card_items/pin_card.dart';
import 'package:hackpsu/data/authentication_repository.dart';
import 'package:hackpsu/data/user_repository.dart';
import 'package:hackpsu/models/registration.dart';
import 'package:hackpsu/utils/cubits/event_cubit.dart';
import 'package:hackpsu/utils/cubits/registration_cubit.dart';
import 'package:hackpsu/utils/cubits/sign_in_cubit.dart';
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
        return BlocBuilder<RegistrationCubit, List<Registration>>(
          builder: (context, registrations) {
            // fetch data first
            context.read<EventCubit>().getEvents();
            context.read<RegistrationCubit>().getUserInfo();

            // while loading show the progress indicator
            if (events == null || registrations == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CountdownTimerCard(),
                  // registrations is passed in from here
                  UserPinCard(registrations),
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
      },
    );
  }
}
