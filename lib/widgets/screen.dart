import 'package:flutter/material.dart';
import 'package:hackpsu/widgets/bottom_navigation.dart';

class Screen extends Scaffold {
  Screen({
    AppBar appBar,
    Color backgroundColor,
    Widget body,
    @required this.withBottomNavigation,
    this.withDismissKeyboard,
  }) : super(
          backgroundColor:
              backgroundColor ?? Color.fromRGBO(224, 224, 224, 1.0),
          appBar: appBar,
          body: withDismissKeyboard
              ? GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus != null
                      ? FocusManager.instance.primaryFocus.unfocus()
                      : null,
                  child: body,
                )
              : body,
          bottomNavigationBar: withBottomNavigation ? BottomNavigation() : null,
        );

  final bool withBottomNavigation;
  final bool withDismissKeyboard;
}
