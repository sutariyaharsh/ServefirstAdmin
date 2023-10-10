import 'package:hive/hive.dart';
import 'package:servefirst_admin/model/request/survey_submit/survey_submit_json_data.dart';

part 'save_survey_pojo.g.dart';
@HiveType(typeId: 13)
class SaveSurveyPojo {
  @HiveField(0)
  String? surveyId;
  @HiveField(1)
  String? surveyName;
  @HiveField(2)
  String? createdAt;
  @HiveField(3)
  String? locationId;
  @HiveField(4)
  String? userId;
  @HiveField(5)
  Map<String, SurveySubmitJsonData>? valueListMapSurveySubmit;
  @HiveField(6)
  Map<String, List<String>>? valueListMapFilesType;
  @HiveField(7)
  Map<String, List<String>>? valueListMapFilesAudition;
}