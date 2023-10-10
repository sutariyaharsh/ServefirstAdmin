import 'package:hive_flutter/hive_flutter.dart';
import 'package:servefirst_admin/model/response/location_survey/location.dart';
import 'package:servefirst_admin/model/response/location_survey/location_survey_data.dart';
import 'package:servefirst_admin/model/response/location_survey/survey.dart';

class LocalGetLocationSurveysService {
  late Box<LocationSurveyData> _LocationSurveyDataBox;

  Future<void> init() async {
    _LocationSurveyDataBox =
        await Hive.openBox<LocationSurveyData>('locationSurveyData');
  }

  Future<void> addLocationSurveyData(
      {required LocationSurveyData locationSurveyData}) async {
    await _LocationSurveyDataBox.put('locationSurveyData', locationSurveyData);
  }

  Future<void> clear() async {
    await _LocationSurveyDataBox.clear();
  }

  LocationSurveyData? getLocationSurveyData() =>
      _LocationSurveyDataBox.get('locationSurveyData');

  Future<Survey?> getSurveyFromSurveyId(
      {required String locationId, required String surveyId}) async {
    List<Location> locationList = getLocationSurveyData()!.location ?? [];
    if (locationList.isNotEmpty) {
      for (var location in locationList) {
        if (location.sId == locationId) {
          for (var survey in location.surveys!) {
            if (survey.sId == surveyId) {
              return survey;
              break;
            }
          }
        }
      }
      for (var survey in getLocationSurveyData()!.global ?? []) {
        if (survey.sId == surveyId) {
          return survey;
          break;
        }
      }
    } else {
      for (var survey in getLocationSurveyData()!.global ?? []) {
        if (survey.sId == surveyId) {
          return survey;
          break;
        }
      }
    }
    return null;
  }
}
