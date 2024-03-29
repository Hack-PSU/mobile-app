import 'package:equatable/equatable.dart';

import '../../api/event.dart';

enum FavoritesStatus { enabled, disabled }

class FavoritesState extends Equatable {
  const FavoritesState._({
    this.status,
    this.items,
  });

  FavoritesState.initialize({
    FavoritesStatus? status,
    Set<String>? items,
  }) : this._(
          status: status ?? FavoritesStatus.disabled,
          items: items ?? <String>{},
        );

  FavoritesState toggleShow() {
    return copyWith(
      status: status == FavoritesStatus.enabled
          ? FavoritesStatus.disabled
          : FavoritesStatus.enabled,
    );
  }

  FavoritesState addItem(Event event) {
    final newItems = Set.of(items!);
    newItems.add(event.id);
    return copyWith(items: newItems);
  }

  FavoritesState removeItem(Event event) {
    final newItems = Set.of(items!);
    newItems.remove(event.id);
    return copyWith(items: newItems);
  }

  FavoritesState copyWith({
    FavoritesStatus? status,
    Set<String?>? items,
  }) {
    return FavoritesState._(
      status: status ?? this.status,
      items: items ?? this.items,
    );
  }

  final FavoritesStatus? status;
  final Set<String?>? items;

  Map<String, dynamic> toJson() {
    return {
      "show": status == FavoritesStatus.enabled,
      "favorites": items!.toList(),
    };
  }

  static FavoritesState fromJson(Map<String, dynamic> json) {
    final status = json["show"] as bool?;
    final favorites = json["favorites"] as List<String>;

    return FavoritesState.initialize(
      status:
          status == true ? FavoritesStatus.enabled : FavoritesStatus.disabled,
      items: favorites.toSet(),
    );
  }

  bool isFavorite(Event event) {
    return items!.contains(event.id);
  }

  @override
  List<Object?> get props => [status, items];
}
