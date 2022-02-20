import 'package:flutter/material.dart';
import 'bottom_navigation.dart';

class Screen extends Scaffold {
  Screen({
    AppBar appBar,
    Color backgroundColor,
    Widget body,
    @required this.withBottomNavigation,
    this.withDismissKeyboard,
    Key key,
  }) : super(
          key: key,
          backgroundColor:
              backgroundColor ?? const Color.fromRGBO(224, 224, 224, 1.0),
          appBar: appBar,
          body: withDismissKeyboard == true
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
