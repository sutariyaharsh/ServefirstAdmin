import 'package:hive_flutter/hive_flutter.dart';
import 'package:servefirst_admin/model/response/survey_dashboard/survey_dashboard_data.dart';

class LocalGetSurveyDashboardDataService {
  late Box<SurveyDashboardData> _surveyDashboardDataBox;

  Future<void> init() async {
    _surveyDashboardDataBox = await Hive.openBox<SurveyDashboardData>('surveyDashboard');
  }

  Future<void> addSurveyDashboardData({required SurveyDashboardData surveyDashboardData}) async {
    await _surveyDashboardDataBox.put('surveyDashboard', surveyDashboardData);
  }

  Future<void> clear() async {
    await _surveyDashboardDataBox.clear();
  }

  SurveyDashboardData? getSurveyDashboardData() => _surveyDashboardDataBox.get('surveyDashboard');
}