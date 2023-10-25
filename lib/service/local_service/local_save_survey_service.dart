import 'package:hive_flutter/hive_flutter.dart';
import 'package:servefirst_admin/model/local_response/save_survey_pojo.dart';

class LocalSaveSurveyService {
  late Box<SaveSurveyPojo> _saveSurveyPojoBox;

  Future<void> init() async {
    _saveSurveyPojoBox = await Hive.openBox<SaveSurveyPojo>('savedSurveys');
  }

  Future<void> addSurvey({required SaveSurveyPojo saveSurveyPojo}) async {
    await _saveSurveyPojoBox.add(saveSurveyPojo);
  }

  List<SaveSurveyPojo> getSavedSurveys() => _saveSurveyPojoBox.values.toList();

  Future<void> updateSurvey({required int index, required SaveSurveyPojo updatedSurvey}) async {
    if (index >= 0 && index < _saveSurveyPojoBox.length) {
      await _saveSurveyPojoBox.putAt(index, updatedSurvey);
    }
  }

  Future<void> removeSurvey({required int index}) async {
    if (index >= 0 && index < _saveSurveyPojoBox.length) {
      await _saveSurveyPojoBox.deleteAt(index);
    }
  }

  Future<void> removeSurveyObj({required SaveSurveyPojo saveSurveyPojo}) async {
    await _saveSurveyPojoBox.delete(saveSurveyPojo);
  }

  Future<SaveSurveyPojo?> getSavedSurvey({required int index}) async {
    if (index >= 0 && index < _saveSurveyPojoBox.length) {
      return _saveSurveyPojoBox.getAt(index);
    } else {
      return null;
    }
  }

  Future<void> clear() async {
    await _saveSurveyPojoBox.clear();
  }
}
