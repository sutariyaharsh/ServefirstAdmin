import 'package:hive/hive.dart';

part 'survey_dashboard_data.g.dart';

@HiveType(typeId: 3)
class SurveyDashboardData {
  @HiveField(0)
  int? totalSurveys;
  @HiveField(1)
  int? totalResponses;
  @HiveField(2)
  num? responseAverage;

  SurveyDashboardData({this.totalSurveys, this.totalResponses, this.responseAverage});

  SurveyDashboardData.fromJson(Map<String, dynamic> json) {
    totalSurveys = json['totalSurveys'];
    totalResponses = json['totalResponses'];
    responseAverage = _parseResponseAverage(json['responseAverage']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalSurveys'] = this.totalSurveys;
    data['totalResponses'] = this.totalResponses;
    data['responseAverage'] = this.responseAverage;
    return data;
  }

  static num _parseResponseAverage(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is double) {
      return value;
    } else {
      throw ArgumentError("Invalid value for responseAverage: $value");
    }
  }
}
