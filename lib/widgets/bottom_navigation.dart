import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bloc/navigation/bottom_navigation_bloc.dart';
import '../bloc/navigation/bottom_navigation_event.dart';

import '../bloc/navigation/bottom_navigation_state.dart';
import '../cubit/bottom_navigation_cubit.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String homeSvg = "assets/icons/bottom_nav_home.svg";
    const String eventsSvg = "assets/icons/bottom_nav_events.svg";
    const String workshopsSvg = "assets/icons/bottom_nav_workshops.svg";
    const Color selectedColor = Color.fromRGBO(106, 133, 185, 1.0);

    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) => BottomNavigationBar(
        currentIndex: state.routeIndex,
        onTap: (index) {
          context
              .read<BottomNavigationBloc>()
              .add(RouteChanged(Routes.values[index]));
          if (state.onNavigationRouteChange != null) {
            state.onNavigationRouteChange!(Routes.values[index]);
          }
        },
        selectedFontSize: 14.0,
        unselectedFontSize: 14.0,
        selectedItemColor: selectedColor,
        selectedIconTheme: const IconThemeData(
          color: selectedColor,
          opacity: 1.0,
        ),
        items: <BottomNavigationBarItem>[
          _createItem(
            "Home",
            SvgPicture.asset(
              homeSvg,
              color: state.route == Routes.Home ? selectedColor : Colors.black,
              width: 25.0,
            ),
          ),
          _createItem(
            "Events",
            SvgPicture.asset(
              eventsSvg,
              color:
                  state.route == Routes.Events ? selectedColor : Colors.black,
              width: 20.0,
            ),
          ),
          _createItem(
            "Workshops",
            SvgPicture.asset(
              workshopsSvg,
              color: state.route == Routes.Workshops
                  ? selectedColor
                  : Colors.black,
              width: 20.0,
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _createItem(String label, Widget icon) =>
      BottomNavigationBarItem(
        icon: Container(
          padding: const EdgeInsets.only(
            top: 2,
            bottom: 6,
          ),
          child: icon,
        ),
        label: label,
      );
}
