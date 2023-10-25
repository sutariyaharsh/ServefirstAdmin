import 'dart:convert';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/constnts/constants.dart';
import 'package:servefirst_admin/controller/network_controller.dart';
import 'package:servefirst_admin/controller/shared_preferences_helper.dart';
import 'package:servefirst_admin/model/request/survey_dashboard_request.dart';
import 'package:servefirst_admin/model/response/survey_dashboard/survey_dashboard.dart';
import 'package:servefirst_admin/model/response/survey_dashboard/survey_dashboard_data.dart';
import 'package:servefirst_admin/service/local_service/local_get_survey_dashboard_data_service.dart';
import 'package:servefirst_admin/service/local_service/local_login_service.dart';
import 'package:servefirst_admin/service/location_service/location_service.dart';
import 'package:servefirst_admin/service/remote_service/remote_get_survey_dashboard_data_service.dart';
import 'package:servefirst_admin/view/dashboard/dashboard_screen.dart';

class ThankYouController extends GetxController {
  static ThankYouController instance = Get.find();
  final LocalLoginService _localLoginService = LocalLoginService();
  final LocalGetSurveyDashboardDataService _localGetSurveyDashboardDataService = LocalGetSurveyDashboardDataService();
  late Position currentPosition;

  @override
  void onInit() async {
    super.onInit();
    await _localLoginService.init();
    await _localGetSurveyDashboardDataService.init();
    currentPosition = await LocationService.getCurrentLocation();
    await startAnimation();
  }

  Future startAnimation() async {
    await getSurveyDashboardData();
    Get.offAll(() => const DashboardScreen());
  }

  Future<void> getSurveyDashboardData() async {
    if (NetworkController.isConnected) {
      try {
        SurveyDashboardRequest surveyDashboardRequest = SurveyDashboardRequest(
            userId: _localLoginService.getUser()!.sId ?? "",
            companyId: _localLoginService.getUser()!.companyId ?? "",
            startDate: await SharedPreferencesHelper.getString(PrefKeys.START_DATE_FILTER) ?? "",
            endDate: await SharedPreferencesHelper.getString(PrefKeys.END_DATE_FILTER) ?? "",
            latitude: currentPosition.latitude,
            longitude: currentPosition.longitude);

        log("Request : ${jsonEncode(surveyDashboardRequest)}", name: "getSurveyDashboardData");

        var result = await RemoteGetSurveyDashboardDataService()
            .getSurveyDashboardData(surveyDashboardRequest: surveyDashboardRequest, token: _localLoginService.getToken() ?? "");
        if (result.statusCode == 200) {
          SurveyDashboard surveyDashboardResponse = SurveyDashboard.fromJson(jsonDecode(result.body));
          if (surveyDashboardResponse.status == 200) {
            await _localGetSurveyDashboardDataService.addSurveyDashboardData(
                surveyDashboardData: surveyDashboardResponse.data ?? SurveyDashboardData());
            log("Response : ${jsonEncode(_localGetSurveyDashboardDataService.getSurveyDashboardData())}", name: "getSurveyDashboardData");
          }
        } else {
          log("Response : ${result.statusCode} ** ${jsonEncode(result.body)}", name: "getSurveyDashboardData");
        }
      } catch (e) {
        log("catch : ${e.toString()}", name: "getSurveyDashboardData");
      }
    }
  }
}
