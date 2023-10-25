import 'package:get/get.dart';
import 'package:servefirst_admin/model/response/location_survey/location.dart';
import 'package:servefirst_admin/service/local_service/local_get_location_surveys_service.dart';

class LocationController extends GetxController {
  static LocationController instance = Get.find();
  final LocalGetLocationSurveysService _localGetLocationSurveysService = LocalGetLocationSurveysService();
  RxList<Location> locationList = List<Location>.empty(growable: true).obs;

  @override
  void onInit() async {
    await _localGetLocationSurveysService.init();
    locationList.assignAll(_localGetLocationSurveysService.getLocationSurveyData()?.location ?? []);
    super.onInit();
  }
}