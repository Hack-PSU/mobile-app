import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/api/event.dart';
import '../../common/api/hackathon/hackathon_model.dart';
import '../../common/api/sponsorship/sponsor_model.dart';
import '../../styles/theme_colors.dart';
import '../../widgets/homepage_header.dart';
import '../../widgets/loading.dart';
import '../../widgets/pin_card.dart';
import '../../widgets/screen/screen.dart';
import '../../widgets/sponsor_carousel.dart';
import 'home_page_cubit.dart';
import 'upcoming_event_card.dart';

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
          body: BlocBuilder<HomePageCubit, HomePageCubitState>(
            buildWhen: (prev, curr) =>
                prev.status != curr.status ||
                prev.events != curr.events ||
                prev.sponsors != curr.sponsors ||
                prev.workshops != curr.workshops ||
                prev.hackathon != curr.hackathon,
            builder: (context, state) {
              if (state.status == PageStatus.idle) {
                context.read<HomePageCubit>().init();
              }
              if (state.status == PageStatus.ready && state.hackathon != null) {
                return _Content(
                  controller: _controller,
                  events: state.events ?? [],
                  sponsors: state.sponsors ?? [],
                  workshops: state.workshops ?? [],
                  hackathon: state.hackathon!,
                );
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
                    "assets/images/ios_icon_retro.png",
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
    required this.events,
    required this.sponsors,
    required this.workshops,
    required this.hackathon,
  }) : _controller = controller;

  final ScrollController? _controller;
  final List<Event> events;
  final List<Event> workshops;
  final Hackathon hackathon;
  final List<Sponsor> sponsors;

  Widget _renderEventCard(BuildContext context, EventType type) {
    if (type == EventType.WORKSHOP) {
      return UpcomingEventCard(
        type: type,
        events: workshops,
      );
    } else {
      return UpcomingEventCard(
        type: type,
        events: events,
      );
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
                HomepageHeader(hackathon: hackathon),
                const UserPinCard(),
                _renderEventCard(context, EventType.ACTIVITY),
                _renderEventCard(context, EventType.WORKSHOP),
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
