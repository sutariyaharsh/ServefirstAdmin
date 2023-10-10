import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:servefirst_admin/constnts/text_strings.dart';
import 'package:servefirst_admin/model/request/location_surveys_request.dart';

class RemoteGetLocationSurveysService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api/adminApp/getLocationSurveys';

  Future<dynamic> getLocationSurveys({
    required LocationSurveysRequest locationSurveysRequest,
    required String token,
  }) async {
    var response = await client.post(
      Uri.parse(remoteUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token
      },
      body: jsonEncode(locationSurveysRequest),
    );
    return response;
  }
}