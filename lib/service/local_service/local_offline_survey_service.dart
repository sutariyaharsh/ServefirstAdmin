import 'package:hive_flutter/hive_flutter.dart';
import 'package:servefirst_admin/model/local_response/offline_survey_pojo.dart';

class LocalOfflineSurveyService {
  late Box<OfflineSurveyPojo> _offlineSurveyPojoBox;

  Future<void> init() async {
    _offlineSurveyPojoBox = await Hive.openBox<OfflineSurveyPojo>('offlineSurveys');
  }

  Future<void> addOfflineSurvey({required OfflineSurveyPojo offlineSurveyPojo}) async {
    await _offlineSurveyPojoBox.add(offlineSurveyPojo);
  }

  List<OfflineSurveyPojo> getOfflineSurveys() => _offlineSurveyPojoBox.values.toList();

  Future<void> updateOfflineSurvey({required int index, required OfflineSurveyPojo updatedOfflineSurvey}) async {
    if (index >= 0 && index < _offlineSurveyPojoBox.length) {
      await _offlineSurveyPojoBox.putAt(index, updatedOfflineSurvey);
    }
  }

  Future<void> removeOfflineSurvey({required int index}) async {
    if (index >= 0 && index < _offlineSurveyPojoBox.length) {
      await _offlineSurveyPojoBox.deleteAt(index);
    }
  }

  Future<OfflineSurveyPojo?> getOfflineSurvey({required int index}) async {
    if (index >= 0 && index < _offlineSurveyPojoBox.length) {
      return _offlineSurveyPojoBox.getAt(index);
    } else {
      return null;
    }
  }

  Future<void> clear() async {
    await _offlineSurveyPojoBox.clear();
  }
}
