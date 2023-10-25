import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:servefirst_admin/model/request/survey_submit/survey_submit_json_data.dart';
import 'package:servefirst_admin/model/request/survey_submit/survey_submit_meta_data.dart';
import 'package:servefirst_admin/model/request/survey_submit/survey_submit_response_data.dart';

part 'offline_survey_pojo.g.dart';

@HiveType(typeId: 16)
class OfflineSurveyPojo {
  @HiveField(0)
  String? userId;
  @HiveField(1)
  Map<String, SurveySubmitJsonData>? jsonData;
  @HiveField(2)
  Map<String, SurveySubmitMetaData>? metaData;
  @HiveField(3)
  Map<String, SurveySubmitResponseData>? responseData;
  @HiveField(4)
  Map<String, List<Uint8List>>? valueListMapFilesType;
  @HiveField(5)
  Map<String, List<Uint8List>>? valueListMapFilesAudition;
}
