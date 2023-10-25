import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:servefirst_admin/constnts/constants.dart';
import 'package:servefirst_admin/controller/network_controller.dart';
import 'package:servefirst_admin/controller/shared_preferences_helper.dart';
import 'package:servefirst_admin/model/request/location_surveys_request.dart';
import 'package:servefirst_admin/model/request/survey_dashboard_request.dart';
import 'package:servefirst_admin/model/response/location_survey/employee.dart';
import 'package:servefirst_admin/model/response/location_survey/location.dart';
import 'package:servefirst_admin/model/response/location_survey/location_survey_data.dart';
import 'package:servefirst_admin/model/response/location_survey/location_surveys.dart';
import 'package:servefirst_admin/model/response/location_survey/survey.dart';
import 'package:servefirst_admin/model/response/survey_dashboard/survey_dashboard.dart';
import 'package:servefirst_admin/model/response/survey_dashboard/survey_dashboard_data.dart';
import 'package:servefirst_admin/service/local_service/local_employee_service.dart';
import 'package:servefirst_admin/service/local_service/local_get_location_surveys_service.dart';
import 'package:servefirst_admin/service/local_service/local_get_survey_dashboard_data_service.dart';
import 'package:servefirst_admin/service/local_service/local_login_service.dart';
import 'package:servefirst_admin/service/location_service/location_service.dart';
import 'package:servefirst_admin/service/remote_service/remote_get_location_surveys_service.dart';
import 'package:servefirst_admin/service/remote_service/remote_get_survey_dashboard_data_service.dart';

class ReportController extends GetxController {
  static ReportController instance = Get.find();
  RxInt totalSurveys = RxInt(0);
  RxInt totalResponse = RxInt(0);
  RxnNum responseAverage = RxnNum(0);
  final LocalLoginService _localLoginService = LocalLoginService();
  final LocalEmployeeService _localEmployeeService = LocalEmployeeService();
  final LocalGetSurveyDashboardDataService _localGetSurveyDashboardDataService = LocalGetSurveyDashboardDataService();
  final LocalGetLocationSurveysService _localGetLocationSurveysService = LocalGetLocationSurveysService();
  RxList<Location> locationList = List<Location>.empty(growable: true).obs;
  RxList<Survey> surveyList = List<Survey>.empty(growable: true).obs;
  late Position currentPosition;

  RxString filterTitle = "".obs;
  RxString filterDates = "".obs;

  @override
  void onInit() async {
    await _localLoginService.init();
    await _localEmployeeService.init();
    await _localGetSurveyDashboardDataService.init();
    await _localGetLocationSurveysService.init();
    if (((await SharedPreferencesHelper.getString(PrefKeys.START_DATE_FILTER) ?? "").isEmpty) &&
        ((await SharedPreferencesHelper.getString(PrefKeys.END_DATE_FILTER) ?? "").isEmpty)) {
      getThisMonthDateRange();
    }

    if (((await SharedPreferencesHelper.getString(PrefKeys.SELECTED_DATE_FILTER) ?? "").isEmpty) &&
        ((await SharedPreferencesHelper.getString(PrefKeys.FILTER_DATES) ?? "").isEmpty)) {
      filterTitle.value = "This Month";
      filterDates.value = getThisMonthDateRange();
    } else {
      filterTitle.value = await SharedPreferencesHelper.getString(PrefKeys.SELECTED_DATE_FILTER) ?? "";
      filterDates.value = await SharedPreferencesHelper.getString(PrefKeys.FILTER_DATES) ?? "";
    }

    currentPosition = await LocationService.getCurrentLocation();

    totalSurveys.value = _localGetSurveyDashboardDataService.getSurveyDashboardData()?.totalSurveys ?? 0;
    totalResponse.value = _localGetSurveyDashboardDataService.getSurveyDashboardData()?.totalResponses ?? 0;
    responseAverage.value = _localGetSurveyDashboardDataService.getSurveyDashboardData()?.responseAverage ?? 0;

    if (_localGetSurveyDashboardDataService.getSurveyDashboardData() == null) {
      await getSurveyDashboardData();
    }
    locationList.assignAll(_localGetLocationSurveysService.getLocationSurveyData()?.location ?? []);
    await getLocationSurveys(false);
    super.onInit();
  }

  Future<bool> isDateSameForApiCall() async {
    String todayDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String previousDate = await SharedPreferencesHelper.getString(PrefKeys.LASTDATE_APICALL) ?? "";

    if (previousDate.isNotEmpty) {
      return todayDate == previousDate;
    } else {
      return false;
    }
  }

  Future<void> getLocationSurveys(bool forceUpdate) async {
    if(!forceUpdate){
      isDateSameForApiCall().then((isSame) async {
        if (!isSame) {
          await getLocationSurveysData();
        }
      });
    }else {
      await getLocationSurveysData();
    }
  }

  Future<void> getLocationSurveysData() async {
    if (NetworkController.isConnected) {
      try {
        EasyLoading.show(
          dismissOnTap: false,
        );
        LocationSurveysRequest locationSurveysRequest = LocationSurveysRequest(
            userId: _localLoginService.getUser()!.sId ?? "",
            companyId: _localLoginService.getUser()!.companyId ?? "",
            latitude: currentPosition.latitude,
            longitude: currentPosition.longitude);

        log("Request : ${jsonEncode(locationSurveysRequest)}", name: "getLocationSurveys");

        var result = await RemoteGetLocationSurveysService()
            .getLocationSurveys(locationSurveysRequest: locationSurveysRequest, token: _localLoginService.getToken() ?? "");
        if (result.statusCode == 200) {
          LocationSurveys locationSurveys = LocationSurveys.fromJson(jsonDecode(result.body));
          if (locationSurveys.status == 200) {
            await _localGetLocationSurveysService.addLocationSurveyData(locationSurveyData: locationSurveys.data ?? LocationSurveyData());
            locationList.assignAll(locationSurveys.data?.location ?? []);
            surveyList.assignAll(locationSurveys.data?.global ?? []);

            List<Employee> employees = [];
            for (var location in locationSurveys.data!.location ?? []) {
              for (var employee in location.employee) {
                final imageUrl = employee.image;
                final imageResponse = await http.get(Uri.parse(imageUrl));
                final imagePath = await saveImageLocally(imageResponse.bodyBytes, employee.id);

                Employee _employee = Employee();
                _employee.locationId = employee.locationId;
                _employee.name = employee.name;
                _employee.id = employee.id;
                _employee.image = imagePath;

                employees.add(_employee);
              }
            }

            _localEmployeeService.assignAllEmployees(employees: employees);
            log("Response : ${jsonEncode(_localGetLocationSurveysService.getLocationSurveyData()!.global!.length)}", name: "getLocationSurveys");
            log("Employees : ${jsonEncode(_localEmployeeService.getEmployees())}", name: "getEmployees");
            saveTodayDate();
            EasyLoading.showSuccess("Success!");
          } else {
            EasyLoading.showError('Something wrong. Try again!');
          }
        } else {
          log("Response : ${result.statusCode} ** ${jsonEncode(result.body)}", name: "getLocationSurveys");
          EasyLoading.showError('wrong. Try again!');
        }
      } catch (e) {
        log("catch : ${e.toString()}", name: "getLocationSurveys");
      } finally {
        EasyLoading.dismiss();
      }
    } else {
      log('You\'re not connected to a network', name: "Network");
      showNetworkErrorSnackBar();
    }
  }

  Future<String> saveImageLocally(List<int> imageBytes, String id) async {
    final appDocumentsDirectory = await getTemporaryDirectory();
    final imagePath = '${appDocumentsDirectory.path}/$id.png';
    final File imageFile = File(imagePath);
    await imageFile.writeAsBytes(imageBytes);
    return imagePath;
  }

  Future<String?> _downloadAndStoreImage(String imageUrl, String id) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        // Get the temporary directory for the app
        final appDir = await getTemporaryDirectory();
        final imagePath = "${appDir.path}/$id.png";

        // Write the image data to the file
        final file = File(imagePath);
        await file.writeAsBytes(response.bodyBytes);
        print("imagePath - $imagePath");
        return imagePath;
      }
    } catch (e) {
      print("Error downloading image: $e");
      return imageUrl;
    }

    // Return null if there's an error or if the image couldn't be downloaded
    return imageUrl;
  }

  Future<void> getSurveyDashboardData() async {
    if (NetworkController.isConnected) {
      try {
        EasyLoading.show(
          dismissOnTap: false,
        );
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
            totalSurveys.value = surveyDashboardResponse.data?.totalSurveys?.toInt() ?? 0;
            totalResponse.value = surveyDashboardResponse.data?.totalResponses?.toInt() ?? 0;
            responseAverage.value = surveyDashboardResponse.data?.responseAverage ?? 0;
            log("Response : ${jsonEncode(_localGetSurveyDashboardDataService.getSurveyDashboardData())}", name: "getSurveyDashboardData");
            EasyLoading.showSuccess("Success!");
          } else {
            EasyLoading.showError('Something wrong. Try again!');
          }
        } else {
          log("Response : ${result.statusCode} ** ${jsonEncode(result.body)}", name: "getSurveyDashboardData");
          EasyLoading.showError('wrong. Try again!');
        }
      } catch (e) {
        log("catch : ${e.toString()}", name: "getSurveyDashboardData");
      } finally {
        EasyLoading.dismiss();
      }
    } else {
      log('You\'re not connected to a network', name: "Network");
      showNetworkErrorSnackBar();
    }
  }

  Future<void> updateFilterData() async {
    filterTitle.value = "Custom Range";
    filterDates.value = await selectCustomDateRange(Get.context!);
    await getSurveyDashboardData();
  }
}
