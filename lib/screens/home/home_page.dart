import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../card_items/homepage_header.dart';
import '../../card_items/next_event_card.dart';
import '../../card_items/pin_card.dart';
import '../../card_items/sponsor_carousel.dart';
import '../../common/api/event.dart';
import '../../common/api/user.dart';
import '../../styles/theme_colors.dart';
import '../../widgets/default_text.dart';
import '../../widgets/loading.dart';
import '../../widgets/screen.dart';
import 'home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late ScrollController? _controller;
  late double? _logoWidth;
  late double? _logoHeight;

  void _scrollListener() {
    if (_controller!.position.pixels <= 50) {
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
    _controller!.addListener(_scrollListener);
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
          body: BlocConsumer<HomeCubit, HomeCubitState>(
            listener: (context, state) {
              if (state.status == PageStatus.idle) {
                context.read<HomeCubit>().init();
              }
            },
            builder: (context, state) {
              if (state.status == PageStatus.ready) {
                return _Content(
                    controller: _controller,
                    users: state.users ?? [],
                    events: state.events ?? [],
                    sponsors: state.sponsors ?? []);
              }
              return const Loading(
                label: "Loading Content...",
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
                  image: AssetImage(
                    "assets/images/logo.png",
                  ),
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
    required ScrollController? controller,
    required this.users,
    required this.events,
    required this.sponsors,
  }) : _controller = controller;

  final ScrollController? _controller;
  final List<User> users;
  final List<Event> events;
  final List<Map<String, String>> sponsors;

  Widget _renderEventCard(BuildContext context, NextEventType type) {
    if (events == null || events.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
        width: MediaQuery.of(context).size.width * 0.95,
        alignment: Alignment.centerLeft,
        child: DefaultText("No upcoming events", textLevel: TextLevel.h4),
      );
    } else {
      return NextEventCard(type: type, events: events);
    }
  }

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
                _renderEventCard(context, NextEventType.EVENT),
                _renderEventCard(context, NextEventType.WORKSHOP),
                const SizedBox(height: 20.0),
                SponsorCarousel(sponsors: sponsors),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        )
      ],
    );
  }
}
