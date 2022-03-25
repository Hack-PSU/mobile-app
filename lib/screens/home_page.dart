import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackpsu/card_items/homepage_header.dart';
import 'package:provider/provider.dart';
import 'package:hackpsu/widgets/agenda.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _controller;
  double _logoWidth;
  double _logoHeight;

  _scrollListener() {
    if (_controller.position.pixels <= 50) {
      setState(() {
        _logoWidth = 135;
        _logoHeight = 135;
      });
    } else {
      setState(() {
        _logoWidth = 70;
        _logoHeight = 70;
      });
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _logoWidth = 135;
    _logoHeight = 135;
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Screen(
          withBottomNavigation: true,
          header: ScreenHeader.only(
            withProfile: true,
          ),
          body: BlocBuilder<EventCubit, List<Event>>(
            builder: (context, events) {
              return BlocBuilder<RegistrationCubit, List<Registration>>(
                builder: (context, registrations) {
                  // fetch data first
                  // context.read<EventCubit>().getEvents();
                  // context.read<RegistrationCubit>().getUserInfo();

                  // while loading show the progress indicator
                  // if (events == null || registrations == null) {
                  //   return const Center(
                  //     child: CircularProgressIndicator(),
                  //   );
                  // }

                  return Column(
                    children: [
                      Expanded(
                        child: ListView(
                          controller: _controller,
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const HomepageHeader(),
                                  // registrations is passed in from here
                                  // UserPinCard(registrations),
                                  // ...events
                                  //     .map((e) => DefaultText(
                                  //           e.eventTitle ?? "Event",
                                  //           fontSize: 14,
                                  //         ))
                                  //     .toList(),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Text("THIS IS A SAMPLE EVENT"),
                                  Button(
                                    variant: ButtonVariant.TextButton,
                                    onPressed: () {
                                      context.read<AuthenticationRepository>().signOut();
                                    },
                                    child: DefaultText(
                                      "Log out",
                                    ),
                                  ),
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
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _logoHeight,
              width: _logoWidth,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Color(0xffF5F5F5),
                image: DecorationImage(
                  image: AssetImage('assets/images/Logo.png'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
