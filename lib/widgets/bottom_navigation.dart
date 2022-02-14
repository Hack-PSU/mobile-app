import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackpsu/utils/cubits/bottom_navigation_cubit.dart';

enum Routes { Home, Events, Workshops }

class BottomNavigation extends StatelessWidget {
  final homeSvg = "assets/icons/bottom_nav_home.svg";
  final eventsSvg = "assets/icons/bottom_nav_events.svg";
  final workshopsSvg = "assets/icons/bottom_nav_workshops.svg";
  final Color selectedColor = Color.fromRGBO(106, 133, 185, 1.0);
  final void Function(Routes item) onSelectItem;

  BottomNavigation({this.onSelectItem});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, Routes>(
      builder: (context, route) => BottomNavigationBar(
        currentIndex: Routes.values.indexOf(route),
        onTap: (index) {
          context.read<BottomNavigationCubit>().navigate(Routes.values[index]);
          if (this.onSelectItem != null) {
            this.onSelectItem(Routes.values[index]);
          }
        },
        selectedFontSize: 14.0,
        unselectedFontSize: 14.0,
        selectedItemColor: selectedColor,
        selectedIconTheme: IconThemeData(
          color: selectedColor,
          opacity: 1.0,
        ),
        items: <BottomNavigationBarItem>[
          _createItem(
            "Home",
            SvgPicture.asset(
              homeSvg,
              color: route == Routes.Home ? selectedColor : Colors.black,
              width: 25.0,
            ),
          ),
          _createItem(
            "Events",
            SvgPicture.asset(
              eventsSvg,
              color: route == Routes.Events ? selectedColor : Colors.black,
              width: 20.0,
            ),
          ),
          _createItem(
            "Workshops",
            SvgPicture.asset(
              workshopsSvg,
              color: route == Routes.Workshops ? selectedColor : Colors.black,
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
          padding: EdgeInsets.only(
            top: 2,
            bottom: 6,
          ),
          child: icon,
        ),
        label: label,
      );
}
