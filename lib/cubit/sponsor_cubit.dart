import 'package:bloc/bloc.dart';

import '../data/sponsorship_repository.dart';

class SponsorshipCubit extends Cubit<List<Map<String, String>>> {
  SponsorshipCubit(
    SponsorshipRepository sponsorshipRepository,
  )   : _sponsorshipRepository = sponsorshipRepository,
        super([]);

  final SponsorshipRepository _sponsorshipRepository;

  Future<void> getSponsors() async {
    final sponsors = await _sponsorshipRepository.getSponsors();
    print(sponsors);
    emit(sponsors);
  }
}
