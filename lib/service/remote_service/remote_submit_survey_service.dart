import 'package:http/http.dart' as http;
import 'package:servefirst_admin/constnts/text_strings.dart';

class RemoteSubmitSurveyService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api/adminApp/submitSurvey';

  Future<dynamic> submitSurvey({
    required List<http.MultipartFile> multipartFiles,
    required String surveySubmitJsonData,
    required String surveySubmitMetaData,
    required String surveySubmitResponseData,
    required String token,
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse(remoteUrl));

    request.files.addAll(multipartFiles);

    // Add the other parameters as fields in the request
    request.fields['jsonData'] = surveySubmitJsonData;
    request.fields['metaData'] = surveySubmitMetaData;
    request.fields['responseData'] = surveySubmitResponseData;

    // Set the authorization token in the request header
    request.headers['Authorization'] = token;

    // Send the request and get the response
    var response = await client.send(request);
    return response;
  }
}
