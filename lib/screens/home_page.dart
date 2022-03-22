import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackpsu/widgets/agenda.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
      header: ScreenHeader.only(
        withProfile: true,
      ),
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
            // context.read<EventCubit>().getEvents();
            // context.read<RegistrationCubit>().getUserInfo();

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
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: [
                      "assets/images/header_mountains.png",
                      "assets/images/Logo.png",
                      "assets/images/Logo.png"
                    ].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration:
                                  const BoxDecoration(color: Colors.blue),
                              child: Image(image: AssetImage(i)));
                        },
                      );
                    }).toList(),
                  )
                  /*CountdownTimerCard(),
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
                  )*/
                ],
              ),
            );
          },
        );
      },
    );
  }
}
