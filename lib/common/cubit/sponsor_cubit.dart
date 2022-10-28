// import 'package:bloc/bloc.dart';
//
// import '../api/sponsorship/sponsorship_repository.dart';
//
// class SponsorshipCubit extends Cubit<List<Map<String, String>>> {
//   SponsorshipCubit(
//     SponsorshipRepository sponsorshipRepository,
//   )   : _sponsorshipRepository = sponsorshipRepository,
//         super([]);
//
//   final SponsorshipRepository _sponsorshipRepository;
//
//   Future<void> getSponsors() async {
//     emit(await _sponsorshipRepository.getSponsors());
//   }
// }
