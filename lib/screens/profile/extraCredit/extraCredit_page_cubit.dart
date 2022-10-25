import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../common/api/extra_credit/extraCredit_repository.dart';
import '../../../common/models/password.dart';




class ExtraCreditCubitState extends Equatable {

  const ExtraCreditCubitState();
  
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ExtraCreditPageCubit extends Cubit<ExtraCreditCubitState> {
    ExtraCreditPageCubit(
      ExtraCreditRepository extraCreditRepository
    )  : _extraCreditRepository = extraCreditRepository,
    super(
      const ExtraCreditCubitState(
        classes: [],
      )
    ) {
      // TODO: implement 
      throw UnimplementedError();
    }

    final ExtraCreditRepository _extraCreditRepository;

}


