import 'package:json_annotation/json_annotation.dart';

part 'sponsor_model.g.dart';

@JsonSerializable(
  createFactory: true,
  createToJson: true,
  fieldRename: FieldRename.snake,
)
class Sponsor {
  Sponsor({
    required this.uid,
    required this.name,
    required this.level,
    required this.logo,
    this.hackathon,
    this.websiteLink,
    required this.order,
  });

  factory Sponsor.fromJson(Map<String, dynamic> json) =>
      _$SponsorFromJson(json);

  Map<String, dynamic> toJson() => _$SponsorToJson(this);

  final int uid;
  final String name;
  final String level;
  final String logo;
  final String? hackathon;

  final String? websiteLink;
  final int order;
}
