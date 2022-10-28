import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../common/api/extra_credit/extra_credit_repository.dart';
import '../../common/api/extra_credit/extra_credit_assignment_model.dart';
import '../../common/api/extra_credit/extra_credit_class_model.dart';

enum PageStatus { idle, loading, ready }

@immutable
class ExtraCreditPageCubitState {
  const ExtraCreditPageCubitState({
    required this.assignments,
    required this.classes,
    this.status = PageStatus.idle,
  });

  final Map<int, ExtraCreditAssignment> assignments;
  final List<ExtraCreditClass> classes;
  final PageStatus status;

  ExtraCreditPageCubitState copyWith({
    Map<int, ExtraCreditAssignment>? assignments,
    List<ExtraCreditClass>? classes,
    PageStatus? status,
  }) {
    return ExtraCreditPageCubitState(
      classes: classes ?? this.classes,
      status: status ?? this.status,
      assignments: assignments ?? this.assignments,
    );
  }
}

class ExtraCreditPageCubit extends Cubit<ExtraCreditPageCubitState> {
  ExtraCreditPageCubit(
    ExtraCreditRepository extraCreditRepository,
  )   : _extraCreditRepository = extraCreditRepository,
        super(
          const ExtraCreditPageCubitState(
            assignments: {},
            classes: [],
          ),
        );

  final ExtraCreditRepository _extraCreditRepository;

  Future<void> getClasses() async {
    final classes = await _extraCreditRepository.getClasses();
    emit(state.copyWith(classes: classes));
  }

  Future<void> getClassAssignmentsByUid() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final classes =
          await _extraCreditRepository.getClassAssignmentsByUid(user.uid);

      print("HERE");

      emit(
        state.copyWith(
          assignments: Map.fromEntries(
            classes.map((c) => MapEntry(c.classUid, c)),
          ),
        ),
      );
    }
  }

  Future<void> registerClass(int uid) async {
    await _extraCreditRepository.registerClass(uid);
  }

  Future<void> unregisterClass(int uid) async {
    await _extraCreditRepository.unregisterClass(uid);
  }

  Future<void> init() async {
    emit(state.copyWith(status: PageStatus.loading));
    await getClasses();
    await getClassAssignmentsByUid();
    emit(state.copyWith(status: PageStatus.ready));
  }

  Future<void> refetch() async {
    emit(state.copyWith(status: PageStatus.idle));
  }
}
