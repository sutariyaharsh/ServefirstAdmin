import 'dart:typed_data';

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
  String? helpDeskName;
  @HiveField(6)
  String? helpDeskEmail;
  @HiveField(7)
  String? helpDeskPhone;
  @HiveField(8)
  Map<String, SurveySubmitJsonData>? valueListMapSurveySubmit;
  @HiveField(9)
  Map<String, List<Uint8List>>? valueListMapFilesType;
  @HiveField(10)
  Map<String, List<Uint8List>>? valueListMapFilesAudition;
}