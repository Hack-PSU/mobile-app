import 'package:json_annotation/json_annotation.dart';

part 'extra_credit_class_model.g.dart';

@JsonSerializable(
  createFactory: true,
  createToJson: true,
)
class ExtraCreditClass {
  ExtraCreditClass({
    required this.uid,
    required this.className,
  });

  String? uid;
  String? className;

  Map<String, dynamic> toJson() => _$ExtraCreditClassToJson(this);

  factory ExtraCreditClass.fromJson(Map<String, dynamic> json) =>
      _$ExtraCreditClassFromJson(json);
}
