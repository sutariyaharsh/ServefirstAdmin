import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:servefirst_admin/controller/network_controller.dart';
import 'package:servefirst_admin/model/local_response/offline_survey_pojo.dart';
import 'package:servefirst_admin/model/request/survey_submit/survey_submit_json_data.dart';
import 'package:servefirst_admin/model/request/survey_submit/survey_submit_meta_data.dart';
import 'package:servefirst_admin/model/request/survey_submit/survey_submit_response_data.dart';
import 'package:servefirst_admin/service/local_service/local_login_service.dart';
import 'package:servefirst_admin/service/local_service/local_offline_survey_service.dart';
import 'package:servefirst_admin/service/remote_service/remote_submit_survey_service.dart';

class OfflineSurveyController extends GetxController {
  static OfflineSurveyController instance = Get.find();
  final LocalOfflineSurveyService _localOfflineSurveyService = LocalOfflineSurveyService();
  final LocalLoginService _localLoginService = LocalLoginService();
  Map<String, SurveySubmitJsonData> surveyJsonDataMap = <String, SurveySubmitJsonData>{};
  Map<String, SurveySubmitMetaData> surveyMetaDataMap = <String, SurveySubmitMetaData>{};
  Map<String, SurveySubmitResponseData> surveyResponseDataMap = <String, SurveySubmitResponseData>{};
  Map<String, List<Uint8List>> imageFileAuditionListMap = <String, List<Uint8List>>{};
  Map<String, List<Uint8List>> imageFileListMap = <String, List<Uint8List>>{};

  @override
  void onInit() async {
    super.onInit();
    await _localLoginService.init();
    await _localOfflineSurveyService.init();
    await autoSubmitSurveyCallApi();
  }

  Future<void> autoSubmitSurveyCallApi() async {
    while (true) {
      log("checked Network : ${NetworkController.isConnected}", name: "autoSubmitSurveyCallApi");
      log("OfflineSurveys : ${_localOfflineSurveyService.getOfflineSurveys().length}", name: "autoSubmitSurveyCallApi");
      if (NetworkController.isConnected) {
        if (_localOfflineSurveyService.getOfflineSurveys().isNotEmpty) {
          for (int i = 0; i < _localOfflineSurveyService.getOfflineSurveys().length; i++) {
            OfflineSurveyPojo offlineSurveyPojo = _localOfflineSurveyService.getOfflineSurveys()[i];
            try {
              if (offlineSurveyPojo.jsonData != null) {
                surveyJsonDataMap = offlineSurveyPojo.jsonData!;
              }
              if (offlineSurveyPojo.metaData != null) {
                surveyMetaDataMap = offlineSurveyPojo.metaData!;
              }
              if (offlineSurveyPojo.responseData != null) {
                surveyResponseDataMap = offlineSurveyPojo.responseData!;
              }
              if (offlineSurveyPojo.valueListMapFilesType != null) {
                imageFileListMap = offlineSurveyPojo.valueListMapFilesType!;
              }
              if (offlineSurveyPojo.valueListMapFilesAudition != null) {
                imageFileAuditionListMap = offlineSurveyPojo.valueListMapFilesAudition!;
              }
              List<http.MultipartFile> multipartFilesList = [];
              // Loop through the map and its values (lists of files)
              await Future.wait(imageFileAuditionListMap.entries.map((entry) async {
                final key = entry.key;
                final uint8List = entry.value;

                await Future.wait(uint8List.map((uint8ListImg) async {
                  String? imageFilePath = await saveImageToTempDirectory(uint8ListImg);
                  var imagePart = await http.MultipartFile.fromPath(key, imageFilePath ?? "");
                  multipartFilesList.add(imagePart);
                }));
              }));

              await Future.wait(imageFileListMap.entries.map((entry) async {
                final key = entry.key;
                final uint8List = entry.value;

                await Future.wait(uint8List.map((uint8ListImg) async {
                  String? imageFilePath = await saveImageToTempDirectory(uint8ListImg);
                  var imagePart = await http.MultipartFile.fromPath(key, imageFilePath ?? "");
                  multipartFilesList.add(imagePart);
                }));
              }));

              log('MultiPartFileList : ${multipartFilesList.length}', name: "autoSubmitSurveyCallApi");
              var result = await RemoteSubmitSurveyService().submitSurvey(
                  multipartFiles: multipartFilesList,
                  surveySubmitJsonData: jsonEncode(surveyJsonDataMap),
                  surveySubmitMetaData: jsonEncode(surveyMetaDataMap["SurveySubmitMetaData"]),
                  surveySubmitResponseData: jsonEncode(surveyResponseDataMap["SurveySubmitResponseData"]),
                  token: _localLoginService.getToken()!);
              if (result.statusCode == 200) {
                var responseBody = await result.stream.bytesToString();
                _localOfflineSurveyService.removeOfflineSurvey(index: i);
              }
            } catch (e) {
              log("catch : ${e.toString()}", name: "autoSubmitSurveyCallApi");
            }
          }
        }
      }
      await Future.delayed(const Duration(seconds: 20));
    }
  }

  Future<String?> saveImageToTempDirectory(Uint8List imageBytes) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      final filePath = '${tempDir.path}/$uniqueFileName.jpg';
      final File imageFile = File(filePath);

      await imageFile.writeAsBytes(imageBytes);
      return filePath;
    } catch (e) {
      print("Error saving image to the temporary directory: $e");
      return null;
    }
  }
}
