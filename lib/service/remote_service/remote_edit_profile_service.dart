import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:servefirst_admin/constnts/text_strings.dart';

class RemoteEditProfileService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api/adminApp/updateProfile';

  Future<dynamic> editProfile({
    required File imageFile,
    required String name,
    required String email,
    required String phone,
    required String token,
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse(remoteUrl));

    // Add the image file as a part of the request
    var imagePart = await http.MultipartFile.fromPath('image', imageFile.path);
    request.files.add(imagePart);

    // Add the other parameters as fields in the request
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['phone'] = phone;

    // Set the authorization token in the request header
    request.headers['Authorization'] = token;

    // Send the request and get the response
    var response = await client.send(request);
    return response;
  }
}