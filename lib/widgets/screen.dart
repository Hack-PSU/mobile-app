import 'package:flutter/material.dart';
import 'package:hackpsu/widgets/bottom_navigation/main.dart';

class Screen extends Scaffold {
  final bool withBottomNavigation;

  Screen({
    AppBar appBar,
    Color backgroundColor,
    Widget body,
    @required this.withBottomNavigation,
  }) : super(
          backgroundColor:
              backgroundColor ?? Color.fromRGBO(224, 224, 224, 1.0),
          appBar: appBar,
          body: body,
          bottomNavigationBar: withBottomNavigation ? BottomNavigation() : null,
        );
}
