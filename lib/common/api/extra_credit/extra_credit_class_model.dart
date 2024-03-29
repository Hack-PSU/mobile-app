import 'package:json_annotation/json_annotation.dart';

part 'extra_credit_class_model.g.dart';

@JsonSerializable(
  createFactory: true,
  createToJson: true,
)
class ExtraCreditClass {
  ExtraCreditClass({
    required this.id,
    required this.name,
    required this.hackathonId,
  });

  factory ExtraCreditClass.fromJson(Map<String, dynamic> json) =>
      _$ExtraCreditClassFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraCreditClassToJson(this);

  final int id;
  final String name;
  final String hackathonId;
}
