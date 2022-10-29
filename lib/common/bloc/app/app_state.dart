import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  const AppState._({
    required this.isConnected,
  });

  const AppState.init()
      : this._(
          isConnected: false,
        );

  final bool isConnected;

  AppState copyWith({
    bool? isConnected,
  }) {
    return AppState._(
      isConnected: isConnected ?? this.isConnected,
    );
  }

  @override
  List<Object?> get props => [isConnected];
}
