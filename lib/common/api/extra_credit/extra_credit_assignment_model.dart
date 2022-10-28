import 'package:json_annotation/json_annotation.dart';

part 'extra_credit_assignment_model.g.dart';

@JsonSerializable(
    createFactory: true, createToJson: true, fieldRename: FieldRename.snake)
class ExtraCreditAssignment {
  ExtraCreditAssignment({
    required this.uid,
    required this.userUid,
    required this.classUid,
    required this.hackathon,
  });

  factory ExtraCreditAssignment.fromJson(Map<String, dynamic> json) =>
      _$ExtraCreditAssignmentFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraCreditAssignmentToJson(this);

  final int uid;
  final String userUid;
  final int classUid;
  final String hackathon;
}
