import 'package:json_annotation/json_annotation.dart';

part 'extra_credit_assignment_model.g.dart';

@JsonSerializable(
  createFactory: true,
  createToJson: true,
)
class ExtraCreditAssignment {
  ExtraCreditAssignment({
    required this.id,
    required this.userId,
    required this.classId,
    required this.hackathonId,
  });

  factory ExtraCreditAssignment.fromJson(Map<String, dynamic> json) =>
      _$ExtraCreditAssignmentFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraCreditAssignmentToJson(this);

  final int id;
  final String userId;
  final int classId;
  final String hackathonId;
}
