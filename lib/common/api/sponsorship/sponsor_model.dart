import 'package:json_annotation/json_annotation.dart';

part 'sponsor_model.g.dart';

@JsonSerializable(
  createFactory: true,
  createToJson: true,
  fieldRename: FieldRename.snake,
)
class Sponsor {
  Sponsor({
    required this.id,
    required this.name,
    required this.level,
    required this.logo,
    this.hackathonId,
    this.link,
    required this.order,
  });

  factory Sponsor.fromJson(Map<String, dynamic> json) =>
      _$SponsorFromJson(json);

  Map<String, dynamic> toJson() => _$SponsorToJson(this);

  final int id;
  final String name;
  final String level;
  final String logo;
  final String? hackathonId;
  final String? link;
  final int order;
}
