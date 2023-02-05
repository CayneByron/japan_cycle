class LastKnownLocation {
  late String id;
  late double latitude;
  late double longitude;
  late DateTime lastUpdated;

  LastKnownLocation({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.lastUpdated,
  });
}