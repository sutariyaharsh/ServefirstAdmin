import 'package:hive/hive.dart';

part 'survey_submit_meta_data.g.dart';

@HiveType(typeId: 17)
class SurveySubmitMetaData {
  @HiveField(0)
  String? surveyId;
  @HiveField(1)
  String? locationId;
  @HiveField(2)
  String? responseUserId;
  @HiveField(3)
  String? tagId;

  SurveySubmitMetaData({
    this.surveyId,
    this.locationId,
    this.responseUserId,
    this.tagId,
  });

  factory SurveySubmitMetaData.fromJson(Map<String, dynamic> json) {
    return SurveySubmitMetaData(
      surveyId: json['survey_id'],
      locationId: json['location_id'],
      responseUserId: json['response_user_id'],
      tagId: json['tag_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'survey_id': surveyId,
      'location_id': locationId,
      'response_user_id': responseUserId,
      'tag_id': tagId,
    };
  }
}