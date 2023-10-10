import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:servefirst_admin/constnts/text_strings.dart';
import 'package:servefirst_admin/model/request/survey_dashboard_request.dart';

class RemoteGetSurveyDashboardDataService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api/adminApp/getSurveyDashboardData';

  Future<dynamic> getSurveyDashboardData({
    required SurveyDashboardRequest surveyDashboardRequest,
    required String token,
  }) async {
    var response = await client.post(
      Uri.parse(remoteUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token
      },
      body: jsonEncode(surveyDashboardRequest),
    );
    return response;
  }
}