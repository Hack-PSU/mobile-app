import 'package:equatable/equatable.dart';
import 'bottom_navigation_state.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();

  @override
  List<Object> get props => [];
}

class RouteChanged extends BottomNavigationEvent {
  const RouteChanged(this.route);

  final Routes route;

  @override
  List<Object> get props => [route];
}
