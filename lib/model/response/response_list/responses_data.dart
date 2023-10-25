import 'package:hive/hive.dart';
import 'package:servefirst_admin/model/response/response_list/answers.dart';
import 'package:servefirst_admin/model/response/response_list/survey_categories.dart';

part 'responses_data.g.dart';

@HiveType(typeId: 10)
class ResponsesData {
  @HiveField(0)
  String? _createdAt;
  @HiveField(1)
  String? _sId;
  @HiveField(2)
  String? _survey;
  @HiveField(3)
  String? _surveyId;
  @HiveField(4)
  String? _surveyDescription;
  @HiveField(5)
  String? _surveyType;
  @HiveField(6)
  String? _surveyCreatedAt;
  @HiveField(7)
  int? _surveyMaxScore;
  @HiveField(8)
  List<Answers>? _answers;
  @HiveField(9)
  List<SurveyCategories>? _surveyCategories;
  @HiveField(10)
  int? _npsScore;
  @HiveField(11)
  int? _questionScore;
  @HiveField(12)
  int? _answerScore;
  @HiveField(13)
  num? _resultPercent;

  ResponsesData(
      {String? createdAt,
      String? sId,
      String? survey,
      String? surveyId,
      String? surveyDescription,
      String? surveyType,
      String? surveyCreatedAt,
      int? surveyMaxScore,
      List<Answers>? answers,
      List<SurveyCategories>? surveyCategories,
      int? npsScore,
      int? questionScore,
      int? answerScore,
      num? resultPercent}) {
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (sId != null) {
      this._sId = sId;
    }
    if (survey != null) {
      this._survey = survey;
    }
    if (surveyId != null) {
      this._surveyId = surveyId;
    }
    if (surveyDescription != null) {
      this._surveyDescription = surveyDescription;
    }
    if (surveyType != null) {
      this._surveyType = surveyType;
    }
    if (surveyCreatedAt != null) {
      this._surveyCreatedAt = surveyCreatedAt;
    }
    if (surveyMaxScore != null) {
      this._surveyMaxScore = surveyMaxScore;
    }
    if (answers != null) {
      this._answers = answers;
    }
    if (surveyCategories != null) {
      this._surveyCategories = surveyCategories;
    }
    if (npsScore != null) {
      this._npsScore = npsScore;
    }
    if (questionScore != null) {
      this._questionScore = questionScore;
    }
    if (answerScore != null) {
      this._answerScore = answerScore;
    }
    if (resultPercent != null) {
      this._resultPercent = resultPercent;
    }
  }

  String? get createdAt => _createdAt;

  set createdAt(String? createdAt) => _createdAt = createdAt;

  String? get sId => _sId;

  set sId(String? sId) => _sId = sId;

  String? get survey => _survey;

  set survey(String? survey) => _survey = survey;

  String? get surveyId => _surveyId;

  set surveyId(String? surveyId) => _surveyId = surveyId;

  String? get surveyDescription => _surveyDescription;

  set surveyDescription(String? surveyDescription) => _surveyDescription = surveyDescription;

  String? get surveyType => _surveyType;

  set surveyType(String? surveyType) => _surveyType = surveyType;

  String? get surveyCreatedAt => _surveyCreatedAt;

  set surveyCreatedAt(String? surveyCreatedAt) => _surveyCreatedAt = surveyCreatedAt;

  int? get surveyMaxScore => _surveyMaxScore;

  set surveyMaxScore(int? surveyMaxScore) => _surveyMaxScore = surveyMaxScore;

  List<Answers>? get answers => _answers;

  set answers(List<Answers>? answers) => _answers = answers;

  List<SurveyCategories>? get surveyCategories => _surveyCategories;

  set surveyCategories(List<SurveyCategories>? surveyCategories) => _surveyCategories = surveyCategories;

  int? get npsScore => _npsScore;

  set npsScore(int? npsScore) => _npsScore = npsScore;

  int? get questionScore => _questionScore;

  set questionScore(int? questionScore) => _questionScore = questionScore;

  int? get answerScore => _answerScore;

  set answerScore(int? answerScore) => _answerScore = answerScore;

  num? get resultPercent => _resultPercent;

  set resultPercent(num? resultPercent) => _resultPercent = resultPercent;

  ResponsesData.fromJson(Map<String, dynamic> json) {
    _createdAt = json['createdAt'];
    _sId = json['_id'];
    _survey = json['survey'];
    _surveyId = json['survey_id'];
    _surveyDescription = json['survey_description'];
    _surveyType = json['survey_type'];
    _surveyCreatedAt = json['survey_created_at'];
    _surveyMaxScore = json['survey_max_score'];
    if (json['answers'] != null) {
      _answers = <Answers>[];
      json['answers'].forEach((v) {
        _answers!.add(new Answers.fromJson(v));
      });
    }
    if (json['surveyCategories'] != null) {
      _surveyCategories = <SurveyCategories>[];
      json['surveyCategories'].forEach((v) {
        _surveyCategories!.add(new SurveyCategories.fromJson(v));
      });
    }
    _npsScore = json['npsScore'];
    _questionScore = json['questionScore'];
    _answerScore = json['answerScore'];
    _resultPercent = json['resultPercent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this._createdAt;
    data['_id'] = this._sId;
    data['survey'] = this._survey;
    data['survey_id'] = this._surveyId;
    data['survey_description'] = this._surveyDescription;
    data['survey_type'] = this._surveyType;
    data['survey_created_at'] = this._surveyCreatedAt;
    data['survey_max_score'] = this._surveyMaxScore;
    if (this._answers != null) {
      data['answers'] = this._answers!.map((v) => v.toJson()).toList();
    }
    if (this._surveyCategories != null) {
      data['surveyCategories'] = this._surveyCategories!.map((v) => v.toJson()).toList();
    }
    data['npsScore'] = this._npsScore;
    data['questionScore'] = this._questionScore;
    data['answerScore'] = this._answerScore;
    data['resultPercent'] = this._resultPercent;
    return data;
  }
}
