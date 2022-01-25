import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum BottomNavigationItems { Home, Events, Workshops }

class BottomNavigation extends StatelessWidget {
  final homeSvg = "assets/icons/bottom_nav_home.svg";
  final eventsSvg = "assets/icons/bottom_nav_events.svg";
  final workshopsSvg = "assets/icons/bottom_nav_workshops.svg";
  final Color selectedColor = Color.fromRGBO(106, 133, 185, 1.0);
  final void Function(BottomNavigationItems item) onSelectItem;

  BottomNavigation({this.onSelectItem});

  BottomNavigationItems _mapIndexToItem(int index) {
    switch (index) {
      case 0:
        return BottomNavigationItems.Home;
      case 1:
        return BottomNavigationItems.Events;
      case 2:
        return BottomNavigationItems.Workshops;
      default:
        return BottomNavigationItems.Home;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        // TODO: Add connection to BlocProvider
        if (this.onSelectItem != null) {
          this.onSelectItem(_mapIndexToItem(index));
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
        BottomNavigationBarItem(
          icon: Container(
            padding: EdgeInsets.only(
              top: 2,
              bottom: 6,
            ),
            child: SvgPicture.asset(
              homeSvg,
              color: selectedColor,
              width: 25.0,
            ),
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: EdgeInsets.only(
              top: 2,
              bottom: 6,
            ),
            child: SvgPicture.asset(
              eventsSvg,
              color: Colors.black,
              width: 20.0,
            ),
          ),
          label: "Events",
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: EdgeInsets.only(
              top: 2,
              bottom: 6,
            ),
            child: SvgPicture.asset(
              workshopsSvg,
              color: Colors.black,
              width: 20.0,
            ),
          ),
          label: "Workshops",
        ),
      ],
    );
  }
}
