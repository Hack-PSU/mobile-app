import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum Routes { Home, Events, Workshops }

class BottomNavigationState extends Equatable {
  const BottomNavigationState._({
    @required this.route,
    this.onNavigationRouteChange,
  });

  const BottomNavigationState.init(
    Routes initialRoute, {
    Function(Routes) onNavigationRouteChange,
  }) : this._(
          route: initialRoute,
          onNavigationRouteChange: onNavigationRouteChange,
        );

  const BottomNavigationState.switchRoute(Routes route) : this._(route: route);

  int get routeIndex => Routes.values.indexOf(route);

  final Routes route;
  final Function(Routes) onNavigationRouteChange;

  @override
  List<Object> get props => [route];
}
