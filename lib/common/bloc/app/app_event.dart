import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class NetworkUpdate extends AppEvent {
  const NetworkUpdate({
    required this.connectivity,
  });

  final ConnectivityResult connectivity;
}

class NetworkAvailable extends AppEvent {}

class NetworkUnavailable extends AppEvent {}
