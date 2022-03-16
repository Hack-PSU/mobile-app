import 'package:equatable/equatable.dart';

abstract class BaseModel extends Equatable {
  const BaseModel();

  @override
  List<Object> get props => [];

  bool isReady();
}
