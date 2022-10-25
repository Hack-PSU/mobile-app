import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable(
    createFactory: true, createToJson: true, fieldRename: FieldRename.snake)
class extraCreditClass {
  extraCreditClass({
    required this.uid,
    required this.className,
  });

  String ?uid;
  String ?className;


  Map<String, dynamic> toJson() => {
    "uid": uid,
    "className": className,
  };
  factory extraCreditClass.fromJson(Map<String, dynamic> json) => _$extraCreditClass(json);

    
}



