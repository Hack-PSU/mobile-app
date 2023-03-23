import 'package:json_annotation/json_annotation.dart';

part 'hackathon_model.g.dart';

@JsonSerializable(
  createFactory: true,
  createToJson: true,
)
class Hackathon {
  Hackathon({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.active,
  });

  factory Hackathon.fromJson(Map<String, dynamic> json) =>
      _$HackathonFromJson(json);

  Map<String, dynamic> toJson() => _$HackathonToJson(this);

  static DateTime _timeFromJson(int int) =>
      DateTime.fromMillisecondsSinceEpoch(int);

  final String id;
  final String name;
  @JsonKey(fromJson: _timeFromJson)
  final DateTime startTime;
  @JsonKey(fromJson: _timeFromJson)
  final DateTime endTime;
  final bool active;
}
