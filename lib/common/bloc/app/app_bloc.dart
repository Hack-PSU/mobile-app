import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : super(
          const AppState.init(),
        ) {
    on<NetworkAvailable>(_onNetworkAvailable);
    on<NetworkUnavailable>(_onNetworkUnavailable);
    on<NetworkUpdate>(_onNetworkUpdate);
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        add(NetworkUpdate(connectivity: result));
      },
    );
  }

  late final StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> _onNetworkUpdate(
    NetworkUpdate event,
    Emitter<AppState> emit,
  ) async {
    if (event.connectivity == ConnectivityResult.none) {
      emit(
        state.copyWith(
          isConnected: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isConnected: true,
        ),
      );
    }
  }

  Future<void> _onNetworkAvailable(
    NetworkAvailable event,
    Emitter<AppState> emit,
  ) async {
    emit(
      state.copyWith(
        isConnected: true,
      ),
    );
  }

  Future<void> _onNetworkUnavailable(
    NetworkUnavailable event,
    Emitter<AppState> emit,
  ) async {
    emit(
      state.copyWith(
        isConnected: false,
      ),
    );
  }

  @override
  Future<void> close() async {
    _connectivitySubscription.cancel();
    super.close();
  }
}
