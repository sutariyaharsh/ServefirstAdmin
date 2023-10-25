import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:servefirst_admin/constnts/text_strings.dart';
import 'package:servefirst_admin/model/request/response_list_request.dart';

class RemoteGetResponseListService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api/adminApp/getResponseList';

  Future<dynamic> getResponseList({
    required ResponseListRequest responseListRequest,
    required String token,
  }) async {
    var response = await client.post(
      Uri.parse(remoteUrl),
      headers: {"Content-Type": "application/json", "Authorization": token},
      body: jsonEncode(responseListRequest),
    );
    return response;
  }
}
