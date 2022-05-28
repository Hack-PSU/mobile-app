import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../card_items/homepage_header.dart';
import '../card_items/next_event_card.dart';
import '../card_items/pin_card.dart';
import '../card_items/sponsor_carousel.dart';
import '../cubit/event_cubit.dart';
import '../cubit/registration_cubit.dart';
import '../cubit/sponsor_cubit.dart';
import '../cubit/workshop_cubit.dart';
import '../data/authentication_repository.dart';
import '../models/event.dart';
import '../models/registration.dart';
import '../styles/theme_colors.dart';
import '../widgets/button.dart';
import '../widgets/default_text.dart';
import '../widgets/loading.dart';
import '../widgets/screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  ScrollController _controller;
  double _logoWidth;
  double _logoHeight;

  void _scrollListener() {
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
          contentBackgroundColor: Colors.white,
          header: ScreenHeader.only(
            withProfile: true,
          ),
          body: BlocBuilder<EventCubit, List<Event>>(
            builder: (context, events) {
              return BlocBuilder<RegistrationCubit, List<Registration>>(
                builder: (context, registrations) {
                  return BlocBuilder<SponsorshipCubit,
                      List<Map<String, String>>>(
                    builder: (context, sponsors) {
                      if (events != null && registrations != null) {
                        return _Content(
                          controller: _controller,
                          events: events,
                          registrations: registrations,
                          sponsors: sponsors,
                        );
                      }
                      return const Loading(
                        label: "Loading Content...",
                      );
                    },
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

class _Content extends StatelessWidget {
  const _Content({
    @required ScrollController controller,
    this.registrations,
    this.events,
    this.sponsors,
  }) : _controller = controller;

  final ScrollController _controller;
  final List<Registration> registrations;
  final List<Event> events;
  final List<Map<String, String>> sponsors;

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: _controller,
      children: [
        Center(
          child: Container(
            decoration: const BoxDecoration(
              color: ThemeColors.Creamery,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const HomepageHeader(),
                const UserPinCard(),
                BlocBuilder<EventCubit, List<Event>>(
                  builder: (context, events) {
                    if (events == null || events.isEmpty) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.0,
                          left: 20.0,
                        ),
                        width: MediaQuery.of(context).size.width * 0.95,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultText(
                              "No upcoming events",
                              textLevel: TextLevel.h4,
                            ),
                          ],
                        ),
                      );
                    }
                    return NextEventCard(
                      events: events,
                      type: NextEventType.EVENT,
                    );
                  },
                ),
                BlocBuilder<WorkshopCubit, List<Event>>(
                  builder: (context, workshops) {
                    if (workshops == null || workshops.isEmpty) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.0,
                          left: 20.0,
                        ),
                        width: MediaQuery.of(context).size.width * 0.95,
                        alignment: Alignment.centerLeft,
                        child: DefaultText(
                          "No upcoming workshops",
                          textLevel: TextLevel.h4,
                        ),
                      );
                    }
                    return NextEventCard(
                      events: workshops,
                      type: NextEventType.WORKSHOP,
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                SponsorCarousel(sponsors: sponsors),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
