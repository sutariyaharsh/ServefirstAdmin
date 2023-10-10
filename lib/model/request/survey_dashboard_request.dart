class SurveyDashboardRequest {
  final String userId;
  final String companyId;
  final String startDate;
  final String endDate;
  final double latitude;
  final double longitude;

  SurveyDashboardRequest({
    required this.userId,
    required this.companyId,
    required this.startDate,
    required this.endDate,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'company_id': companyId,
      'start_date': startDate,
      'end_date': endDate,
      'lat': latitude,
      'long': longitude,
    };
  }
}