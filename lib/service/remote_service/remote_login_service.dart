import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:servefirst_admin/constnts/text_strings.dart';
import 'package:servefirst_admin/model/request/login_request.dart';

class RemoteLoginService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/auth/v2/login';

  Future<dynamic> login({
    required LoginRequest loginRequest,
  }) async {
    var response = await client.post(
      Uri.parse(remoteUrl),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(loginRequest),
    );
    return response;
  }
}
