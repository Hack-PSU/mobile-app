import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../common/api/registration/registration_body_model.dart';
import '../../common/api/registration/registration_repository.dart';

class RegistrationCubitState extends Equatable {
  const RegistrationCubitState._({
    this.eighteenBeforeEvent,
    this.shareAddressSponsors,
    this.travelReimbursement,
    this.shareAddressMlh,
    this.educationalInstitutionType,
    this.academicYear,
    this.codingExperience,
    this.expectations,
    this.driving,
    this.firstHackathon,
    this.mlhCoc,
    this.mlhDcp,
    this.project,
    this.referral,
    this.shareEmailMlh,
    this.veteran,
    this.isSubmitting,
  });

  const RegistrationCubitState.init()
      : this._(
          mlhCoc: false,
          mlhDcp: false,
          expectations: "",
          travelReimbursement: false,
          shareAddressSponsors: false,
        );

  RegistrationCubitState copyWith({
    bool? eighteenBeforeEvent,
    bool? shareAddressSponsors,
    bool? travelReimbursement,
    bool? shareAddressMlh,
    String? educationalInstitutionType,
    String? academicYear,
    String? codingExperience,
    String? expectations,
    bool? driving,
    bool? firstHackathon,
    bool? mlhCoc,
    bool? mlhDcp,
    String? project,
    String? referral,
    bool? shareEmailMlh,
    String? veteran,
    bool? isSubmitting,
  }) {
    return RegistrationCubitState._(
      academicYear: academicYear ?? this.academicYear,
      codingExperience: codingExperience ?? this.codingExperience,
      driving: driving ?? this.driving,
      educationalInstitutionType:
          educationalInstitutionType ?? this.educationalInstitutionType,
      eighteenBeforeEvent: eighteenBeforeEvent ?? this.eighteenBeforeEvent,
      expectations: expectations ?? this.expectations,
      firstHackathon: firstHackathon ?? this.firstHackathon,
      mlhCoc: mlhCoc ?? this.mlhCoc,
      mlhDcp: mlhDcp ?? this.mlhDcp,
      project: project ?? this.project,
      referral: referral ?? this.referral,
      shareAddressMlh: shareAddressMlh ?? this.shareAddressMlh,
      shareAddressSponsors: shareAddressSponsors ?? this.shareAddressSponsors,
      travelReimbursement: travelReimbursement ?? this.travelReimbursement,
      shareEmailMlh: shareEmailMlh ?? this.shareEmailMlh,
      veteran: veteran ?? this.veteran,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  final bool? eighteenBeforeEvent;
  final bool? shareAddressSponsors;
  final bool? travelReimbursement;
  final bool? shareAddressMlh;
  final String? educationalInstitutionType;
  final String? academicYear;
  final String? codingExperience;
  final String? expectations;
  final bool? driving;
  final bool? firstHackathon;
  final bool? mlhCoc;
  final bool? mlhDcp;
  final String? project;
  final String? referral;
  final bool? shareEmailMlh;
  final String? veteran;
  final bool? isSubmitting;

  @override
  List<Object?> get props => [
        eighteenBeforeEvent,
        shareAddressSponsors,
        travelReimbursement,
        shareAddressMlh,
        educationalInstitutionType,
        academicYear,
        codingExperience,
        expectations,
        driving,
        firstHackathon,
        mlhCoc,
        mlhDcp,
        project,
        referral,
        shareEmailMlh,
        veteran,
        isSubmitting,
      ];
}

class RegistrationCubit extends Cubit<RegistrationCubitState> {
  RegistrationCubit({
    required RegistrationRepository registrationRepository,
  })  : _registrationRepository = registrationRepository,
        _firebaseAuth = FirebaseAuth.instance,
        super(const RegistrationCubitState.init());

  final RegistrationRepository _registrationRepository;
  final FirebaseAuth _firebaseAuth;

  void copyWith({
    bool? eighteenBeforeEvent,
    bool? shareAddressSponsors,
    bool? travelReimbursement,
    bool? shareAddressMlh,
    String? educationalInstitutionType,
    String? academicYear,
    String? codingExperience,
    String? expectations,
    bool? driving,
    bool? firstHackathon,
    bool? mlhCoc,
    bool? mlhDcp,
    String? project,
    String? referral,
    bool? shareEmailMlh,
    String? veteran,
    bool? isSubmitting,
  }) {
    emit(
      state.copyWith(
        academicYear: academicYear ?? state.academicYear,
        codingExperience: codingExperience ?? state.codingExperience,
        driving: driving ?? state.driving,
        educationalInstitutionType:
            educationalInstitutionType ?? state.educationalInstitutionType,
        eighteenBeforeEvent: eighteenBeforeEvent ?? state.eighteenBeforeEvent,
        expectations: expectations ?? state.expectations,
        firstHackathon: firstHackathon ?? state.firstHackathon,
        mlhCoc: mlhCoc ?? state.mlhCoc,
        mlhDcp: mlhDcp ?? state.mlhDcp,
        project: project ?? state.project,
        referral: referral ?? state.referral,
        shareAddressMlh: shareAddressMlh ?? state.shareAddressMlh,
        shareAddressSponsors:
            shareAddressSponsors ?? state.shareAddressSponsors,
        travelReimbursement: travelReimbursement ?? state.travelReimbursement,
        shareEmailMlh: shareEmailMlh ?? state.shareEmailMlh,
        veteran: veteran ?? state.veteran,
        isSubmitting: isSubmitting ?? state.isSubmitting,
      ),
    );
  }

  Future<void> submit() async {
    emit(state.copyWith(isSubmitting: true));
    final user = _firebaseAuth.currentUser;

    if (user != null) {
      final registration = RegistrationBody(
        academicYear: state.academicYear,
        codingExperience: state.codingExperience,
        driving: state.driving,
        educationalInstitutionType: state.educationalInstitutionType,
        eighteenBeforeEvent: state.eighteenBeforeEvent,
        expectations: state.expectations,
        firstHackathon: state.firstHackathon,
        mlhCoc: state.mlhCoc,
        mlhDcp: state.mlhDcp,
        project: state.project,
        referral: state.referral,
        shareAddressMlh: state.shareAddressMlh,
        shareAddressSponsors: state.shareAddressSponsors,
        travelReimbursement: state.travelReimbursement,
        shareEmailMlh: state.shareEmailMlh,
        veteran: state.veteran,
        time: DateTime.now(),
      );

      await _registrationRepository.registerUser(registration);
    }
    emit(state.copyWith(isSubmitting: false));
  }
}
