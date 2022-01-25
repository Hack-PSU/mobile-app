import 'package:flutter/material.dart';
import 'package:hackpsu/widgets/bottom_navigation.dart';

class Screen extends Scaffold {
  static GlobalKey<ScaffoldState> _keyScaffold = GlobalKey();
  final bool withBottomNavigation;

  Screen({
    AppBar appBar,
    Color backgroundColor,
    Widget body,
    @required this.withBottomNavigation,
  }) : super(
          backgroundColor:
              backgroundColor ?? Color.fromRGBO(224, 224, 224, 1.0),
          key: _keyScaffold,
          appBar: appBar,
          bottomNavigationBar: withBottomNavigation ? BottomNavigation() : null,
        );
}
