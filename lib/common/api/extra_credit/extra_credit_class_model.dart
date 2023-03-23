import 'package:json_annotation/json_annotation.dart';

part 'extra_credit_class_model.g.dart';

@JsonSerializable(
  createFactory: true,
  createToJson: true,
  fieldRename: FieldRename.snake,
)
class ExtraCreditClass {
  ExtraCreditClass({
    required this.uid,
    required this.className,
  });

  factory ExtraCreditClass.fromJson(Map<String, dynamic> json) =>
      _$ExtraCreditClassFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraCreditClassToJson(this);

  final int uid;
  final String className;
}
