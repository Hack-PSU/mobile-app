import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../common/api/extra_credit/extra_credit_repository.dart';
import '../../common/api/extra_credit/extra_credit_class_model.dart';
import '../../common/api/websocket.dart';

enum PageStatus { idle, loading, ready }

class ExtraCreditPageCubitState {
  const ExtraCreditPageCubitState({
    required this.assignments,
    required this.classes,
    this.status = PageStatus.idle,
  });

  final Map<int, ExtraCreditClass> assignments;
  final List<ExtraCreditClass> classes;
  final PageStatus status;

  ExtraCreditPageCubitState copyWith({
    Map<int, ExtraCreditClass>? assignments,
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
        ) {
    _socketSubscription = SocketManager.instance.socket.listen((data) {
      switch (data.event) {
        case "update:hackathon": // fall through
        case "update:extraCredit":
          refetch();
          break;
      }
    });
  }

  final ExtraCreditRepository _extraCreditRepository;
  late final StreamSubscription<SocketData> _socketSubscription;

  Future<void> getClasses() async {
    final classes = await _extraCreditRepository.getAllClasses();
    emit(state.copyWith(classes: classes));
  }

  Future<void> getClassesForUser() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final classes = await _extraCreditRepository.getClassesForUser();

      emit(
        state.copyWith(
          assignments: Map.fromEntries(
            classes.map((c) => MapEntry(c.id, c)),
          ),
        ),
      );
    }
  }

  Future<void> registerClass(int uid) async {
    await _extraCreditRepository.registerClass(uid);
  }

  Future<void> unregisterClass(int id) async {
    await _extraCreditRepository.unregisterClass(id);
  }

  Future<void> init() async {
    emit(state.copyWith(status: PageStatus.loading));
    await getClasses();
    await getClassesForUser();
    emit(state.copyWith(status: PageStatus.ready));
  }

  Future<void> refetch() async {
    emit(state.copyWith(status: PageStatus.idle));
  }

  @override
  Future<void> close() async {
    await _socketSubscription.cancel();
    super.close();
  }
}
