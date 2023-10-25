import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/constnts/constants.dart';
import 'package:servefirst_admin/controller/network_controller.dart';
import 'package:servefirst_admin/model/local_response/save_survey_pojo.dart';
import 'package:servefirst_admin/model/request/response_list_request.dart';
import 'package:servefirst_admin/model/response/location_survey/survey.dart';
import 'package:servefirst_admin/model/response/response_list/response_list.dart';
import 'package:servefirst_admin/model/response/response_list/responses_data.dart';
import 'package:servefirst_admin/service/local_service/local_get_location_surveys_service.dart';
import 'package:servefirst_admin/service/local_service/local_get_response_list_service.dart';
import 'package:servefirst_admin/service/local_service/local_login_service.dart';
import 'package:servefirst_admin/service/local_service/local_save_survey_service.dart';
import 'package:servefirst_admin/service/remote_service/remote_get_response_list_service.dart';

class SurveyResponsesController extends GetxController {
  static SurveyResponsesController instance = Get.find();
  RxList<ResponsesData> responsesDataList = List<ResponsesData>.empty(growable: true).obs;
  RxList<SaveSurveyPojo> savedResponsesList = List<SaveSurveyPojo>.empty(growable: true).obs;
  RxInt page = RxInt(1);
  final LocalGetLocationSurveysService _localGetLocationSurveysService = LocalGetLocationSurveysService();
  final LocalLoginService _localLoginService = LocalLoginService();
  final LocalSaveSurveyService _localSaveSurveyService = LocalSaveSurveyService();
  final LocalGetResponseListService _localGetResponseListService = LocalGetResponseListService();

  @override
  void onInit() async {
    await _localLoginService.init();
    await _localGetLocationSurveysService.init();
    await _localGetResponseListService.init();
    await _localSaveSurveyService.init();

    await getResponseList(page.value);
    await getSavedSurvey();
    super.onInit();
  }

  Future<Survey?> getSurveyFromSurveyId(String surveyId, String locationId) async {
    return await _localGetLocationSurveysService.getSurveyFromSurveyId(locationId: locationId, surveyId: surveyId);
  }

  Future<void> getSavedSurvey() async {
    if (_localSaveSurveyService.getSavedSurveys().isNotEmpty) {
      savedResponsesList.assignAll(_localSaveSurveyService.getSavedSurveys());
    }
  }

  Future<void> getResponseList(int page) async {
    if (NetworkController.isConnected) {
      try {
        EasyLoading.show(
          dismissOnTap: false,
        );
        if (_localGetResponseListService.getResponseData()!.isNotEmpty) {
          responsesDataList.assignAll(_localGetResponseListService.getResponseData()!);
        }
        ResponseListRequest responseListRequest = ResponseListRequest(userId: _localLoginService.getUser()!.sId ?? "", page: page);
        log("Request : ${jsonEncode(responseListRequest)}", name: "getResponseList");
        var result = await RemoteGetResponseListService()
            .getResponseList(responseListRequest: responseListRequest, token: _localLoginService.getToken() ?? "");
        if (result.statusCode == 200) {
          ResponseList responseList = ResponseList.fromJson(jsonDecode(result.body));
          if (responseList.status == 200) {
            responsesDataList.assignAll(responseDataListFromJson(result.body));
            await _localGetResponseListService.assignAllResponsesData(responsesData: responseDataListFromJson(result.body));
            EasyLoading.dismiss();
          } else {
            EasyLoading.showError('Something wrong. Try again!');
          }
        } else {
          log("Response : ${result.statusCode} ** ${jsonEncode(result.body)}", name: "getResponseList");
          EasyLoading.showError('wrong. Try again!');
        }
      } catch (e) {
        log("catch : ${e.toString()}", name: "getResponseList");
        EasyLoading.showError('Something wrong. Try again!');
      } finally {
        EasyLoading.dismiss();
      }
    } else {
      log('You\'re not connected to a network', name: "Network");
      showNetworkErrorSnackBar();
    }
  }
}
