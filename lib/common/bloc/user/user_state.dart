import 'package:equatable/equatable.dart';

import '../../api/user/user_model.dart';

class UserState extends Equatable {
  const UserState._({
    required this.userId,
    this.token,
    this.profile,
    this.exists = true,
  });

  const UserState.initialize()
      : this._(
          token: "",
          userId: "",
          profile: null,
          exists: true,
        );

  final String? token;
  final String? userId;
  final User? profile;
  final bool exists;

  UserState copyWith({
    String? userId,
    String? token,
    User? profile,
    bool? exists,
  }) {
    return UserState._(
      token: token ?? this.token,
      userId: userId ?? this.userId,
      profile: profile ?? this.profile,
      exists: exists ?? this.exists,
    );
  }

  static UserState fromJson(Map<String, dynamic> json) {
    return UserState._(
      token: "",
      userId: json["userId"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {"userId": userId};
  }

  @override
  List<Object?> get props => [token, userId, profile, exists];
}
