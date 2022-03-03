import 'package:bloc/bloc.dart';
import 'bottom_navigation_event.dart';
import 'bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc(
    Routes initialRoute, {
    Function(Routes) onNavigationRouteChange,
  }) : super(
          BottomNavigationState.init(
            initialRoute,
            onNavigationRouteChange: onNavigationRouteChange,
          ),
        ) {
    onNavigationRouteChange(initialRoute);
    on<RouteChanged>(_onRouteChanged);
  }

  void _onRouteChanged(
      RouteChanged event, Emitter<BottomNavigationState> emit) {
    emit(
      BottomNavigationState.switchRoute(
        event.route,
      ),
    );
  }
}
