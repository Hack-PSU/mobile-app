import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/api/extra_credit/extra_credit_repository.dart';
import '../../common/api/extra_credit/extra_credit_class_model.dart';

enum PageStatus { idle, loading, ready }

class ExtraCreditPageCubitState extends Equatable {
  const ExtraCreditPageCubitState({
    this.classes,
    this.status = PageStatus.idle,
  });

  final List<ExtraCreditClass>? classes;
  final PageStatus status;

  ExtraCreditPageCubitState copyWith({
    List<ExtraCreditClass>? classes,
    PageStatus? status,
  }) {
    return ExtraCreditPageCubitState(
      classes: classes ?? this.classes,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [classes, status];
}

class ExtraCreditPageCubit extends Cubit<ExtraCreditPageCubitState> {
  ExtraCreditPageCubit(
    ExtraCreditRepository extraCreditRepository,
  )   : _extraCreditRepository = extraCreditRepository,
        super(
          const ExtraCreditPageCubitState(
            classes: [],
          ),
        );

  final ExtraCreditRepository _extraCreditRepository;

  Future<void> getClasses() async {
    final classes = await _extraCreditRepository.getClasses();
    emit(state.copyWith(classes: classes));
  }

  Future<void> init() async {
    emit(state.copyWith(status: PageStatus.loading));
    await getClasses();
    emit(state.copyWith(status: PageStatus.ready));
  }

  Future<void> refetch() async {
    emit(state.copyWith(status: PageStatus.idle));
  }
}
