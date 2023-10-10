class SurveySubmitMetaData {
  String? surveyId;
  String? locationId;
  String? responseUserId;
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