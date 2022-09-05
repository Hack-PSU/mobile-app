import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/navigation/bottom_navigation_bloc.dart';
import '../bloc/navigation/bottom_navigation_state.dart';
import '../screens/event/events_page.dart';
import '../screens/home/home_page.dart';
import '../screens/workshop/workshops_page.dart';

class MainRouter extends StatelessWidget {
  const MainRouter({Key? key}) : super(key: key);

  static const List<Widget> _pages = [
    HomePage(),
    EventsPage(),
    WorkshopsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavigationBloc>(
      create: (context) {
        return BottomNavigationBloc(
          Routes.Home,
          onNavigationRouteChange: (route) {
            switch (route) {
              case Routes.Home:
                // context.read<HomeCubit>().init();
                break;
              case Routes.Events:
                // context.read<EventCubit>().getEvents();
                break;
              case Routes.Workshops:
                // context.read<WorkshopCubit>().getWorkshops();
                break;
            }
          },
        );
      },
      child: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) => _pages[state.routeIndex],
      ),
    );
  }
}
