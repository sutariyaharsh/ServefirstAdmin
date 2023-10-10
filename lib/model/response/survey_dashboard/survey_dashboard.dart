import 'package:servefirst_admin/model/response/survey_dashboard/survey_dashboard_data.dart';

class SurveyDashboard {
  int? status;
  String? message;
  SurveyDashboardData? data;

  SurveyDashboard({this.status, this.message, this.data});

  SurveyDashboard.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new SurveyDashboardData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
