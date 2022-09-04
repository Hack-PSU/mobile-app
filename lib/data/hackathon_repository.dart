class HackathonRepository {
  HackathonRepository(String configUrl) : _endpoint = Uri.parse(configUrl);

  final Uri _endpoint;
}
