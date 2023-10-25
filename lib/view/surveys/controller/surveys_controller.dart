import 'package:get/get.dart';
import 'package:servefirst_admin/model/response/location_survey/location.dart';
import 'package:servefirst_admin/model/response/location_survey/survey.dart';
import 'package:servefirst_admin/service/local_service/local_get_location_surveys_service.dart';

class SurveysController extends GetxController {
  static SurveysController instance = Get.find();
  final int index;
  final RxString locationId = ''.obs;

  SurveysController(this.index);

  final LocalGetLocationSurveysService _localGetLocationSurveysService = LocalGetLocationSurveysService();
  RxList<Location> locationList = List<Location>.empty(growable: true).obs;
  RxList<Survey> surveyList = List<Survey>.empty(growable: true).obs;

  @override
  void onInit() async {
    await _localGetLocationSurveysService.init();
    locationList.assignAll(_localGetLocationSurveysService.getLocationSurveyData()?.location ?? []);
    surveyList.clear();
    if (locationList.isNotEmpty) {
      locationId.value = locationList[index].sId!;
      surveyList.assignAll(locationList[index].surveys ?? []);
      surveyList.addAll(_localGetLocationSurveysService.getLocationSurveyData()?.global ?? []);
    } else {
      surveyList.assignAll(_localGetLocationSurveysService.getLocationSurveyData()?.global ?? []);
    }
    super.onInit();
  }
}
