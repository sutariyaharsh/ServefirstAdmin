class LocationSurveysRequest {
  final String userId;
  final String companyId;
  final double latitude;
  final double longitude;

  LocationSurveysRequest({
    required this.userId,
    required this.companyId,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'company_id': companyId,
      'lat': latitude,
      'long': longitude,
    };
  }
}