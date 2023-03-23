import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  const UserState._({
    required this.uid,
    this.token,
  });

  const UserState.initialize()
      : this._(
          token: "",
          uid: "",
        );

  final String? token;
  final String uid;

  UserState copyWith({
    String? token,
    String? uid,
  }) {
    return UserState._(
      token: token ?? this.token,
      uid: uid ?? this.uid,
    );
  }

  static UserState fromJson(Map<String, dynamic> json) {
    final uid = json["uid"] as String?;
    return UserState._(
      token: "",
      uid: uid ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {"uid": uid};
  }

  @override
  List<Object?> get props => [token, uid];
}
