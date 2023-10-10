import 'package:hive/hive.dart';
import 'package:servefirst_admin/model/response/location_survey/question.dart';

part 'survey.g.dart';
@HiveType(typeId: 7)
class Survey {
  @HiveField(0)
  String? _sId;
  @HiveField(1)
  String? _name;
  @HiveField(2)
  String? _description;
  @HiveField(3)
  int? _questionsPerPage;
  @HiveField(4)
  String? _companyId;
  @HiveField(5)
  String? _surveyType;
  @HiveField(6)
  List<Questions>? _questions;
  @HiveField(7)
  String? _userTagId;
  @HiveField(8)
  String? _image;
  @HiveField(9)
  int? _maxScore;
  @HiveField(10)
  bool? _status;
  @HiveField(11)
  bool? _isGlobal;
  @HiveField(12)
  String? _showIn;
  @HiveField(13)
  bool? _helpDesk;
  @HiveField(14)
  bool? _showCategory;
  @HiveField(15)
  String? _updatedAt;
  @HiveField(16)
  String? _createdAt;
  @HiveField(17)
  int? _iV;
  @HiveField(18)
  String? _leadershipUserId;
  @HiveField(19)
  String? _responseNotificationMails;
  @HiveField(20)
  int? _idealDuration;

  Survey(
      {String? sId,
      String? name,
      String? description,
      int? questionsPerPage,
      String? companyId,
      String? surveyType,
      List<Questions>? questions,
      String? userTagId,
      String? image,
      int? maxScore,
      bool? status,
      bool? isGlobal,
      String? showIn,
      bool? helpDesk,
      bool? showCategory,
      String? updatedAt,
      String? createdAt,
      int? iV,
      String? leadershipUserId,
      String? responseNotificationMails,
      int? idealDuration}) {
    if (sId != null) {
      this._sId = sId;
    }
    if (name != null) {
      this._name = name;
    }
    if (description != null) {
      this._description = description;
    }
    if (questionsPerPage != null) {
      this._questionsPerPage = questionsPerPage;
    }
    if (companyId != null) {
      this._companyId = companyId;
    }
    if (surveyType != null) {
      this._surveyType = surveyType;
    }
    if (questions != null) {
      this._questions = questions;
    }
    if (userTagId != null) {
      this._userTagId = userTagId;
    }
    if (image != null) {
      this._image = image;
    }
    if (maxScore != null) {
      this._maxScore = maxScore;
    }
    if (status != null) {
      this._status = status;
    }
    if (isGlobal != null) {
      this._isGlobal = isGlobal;
    }
    if (showIn != null) {
      this._showIn = showIn;
    }
    if (helpDesk != null) {
      this._helpDesk = helpDesk;
    }
    if (showCategory != null) {
      this._showCategory = showCategory;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (iV != null) {
      this._iV = iV;
    }
    if (leadershipUserId != null) {
      this._leadershipUserId = leadershipUserId;
    }
    if (responseNotificationMails != null) {
      this._responseNotificationMails = responseNotificationMails;
    }
    if (idealDuration != null) {
      this._idealDuration = idealDuration;
    }
  }

  String? get sId => _sId;

  set sId(String? sId) => _sId = sId;

  String? get name => _name;

  set name(String? name) => _name = name;

  String? get description => _description;

  set description(String? description) => _description = description;

  int? get questionsPerPage => _questionsPerPage;

  set questionsPerPage(int? questionsPerPage) =>
      _questionsPerPage = questionsPerPage;

  String? get companyId => _companyId;

  set companyId(String? companyId) => _companyId = companyId;

  String? get surveyType => _surveyType;

  set surveyType(String? surveyType) => _surveyType = surveyType;

  List<Questions>? get questions => _questions;

  set questions(List<Questions>? questions) => _questions = questions;

  String? get userTagId => _userTagId;

  set userTagId(String? userTagId) => _userTagId = userTagId;

  String? get image => _image;

  set image(String? image) => _image = image;

  int? get maxScore => _maxScore;

  set maxScore(int? maxScore) => _maxScore = maxScore;

  bool? get status => _status;

  set status(bool? status) => _status = status;

  bool? get isGlobal => _isGlobal;

  set isGlobal(bool? isGlobal) => _isGlobal = isGlobal;

  String? get showIn => _showIn;

  set showIn(String? showIn) => _showIn = showIn;

  bool? get helpDesk => _helpDesk;

  set helpDesk(bool? helpDesk) => _helpDesk = helpDesk;

  bool? get showCategory => _showCategory;

  set showCategory(bool? showCategory) => _showCategory = showCategory;

  String? get updatedAt => _updatedAt;

  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  String? get createdAt => _createdAt;

  set createdAt(String? createdAt) => _createdAt = createdAt;

  int? get iV => _iV;

  set iV(int? iV) => _iV = iV;

  String? get leadershipUserId => _leadershipUserId;

  set leadershipUserId(String? leadershipUserId) =>
      _leadershipUserId = leadershipUserId;

  String? get responseNotificationMails => _responseNotificationMails;

  set responseNotificationMails(String? responseNotificationMails) =>
      _responseNotificationMails = responseNotificationMails;

  int? get idealDuration => _idealDuration;

  set idealDuration(int? idealDuration) => _idealDuration = idealDuration;

  Survey.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _name = json['name'];
    _description = json['description'];
    _questionsPerPage = json['questions_per_page'];
    _companyId = json['company_id'];
    _surveyType = json['surveyType'];
    if (json['questions'] != null) {
      _questions = <Questions>[];
      json['questions'].forEach((v) {
        _questions!.add(new Questions.fromJson(v));
      });
    }
    _userTagId = json['user_tag_id'];
    _image = json['image'];
    _maxScore = json['maxScore'];
    _status = json['status'];
    _isGlobal = json['is_global'];
    _showIn = json['show_in'];
    _helpDesk = json['help_desk'];
    _showCategory = json['show_category'];
    _updatedAt = json['updatedAt'];
    _createdAt = json['createdAt'];
    _iV = json['__v'];
    _leadershipUserId = json['leadership_user_id'];
    _responseNotificationMails = json['response_notification_mails'];
    _idealDuration = json['ideal_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this._sId;
    data['name'] = this._name;
    data['description'] = this._description;
    data['questions_per_page'] = this._questionsPerPage;
    data['company_id'] = this._companyId;
    data['surveyType'] = this._surveyType;
    if (this._questions != null) {
      data['questions'] = this._questions!.map((v) => v.toJson()).toList();
    }
    data['user_tag_id'] = this._userTagId;
    data['image'] = this._image;
    data['maxScore'] = this._maxScore;
    data['status'] = this._status;
    data['is_global'] = this._isGlobal;
    data['show_in'] = this._showIn;
    data['help_desk'] = this._helpDesk;
    data['show_category'] = this._showCategory;
    data['updatedAt'] = this._updatedAt;
    data['createdAt'] = this._createdAt;
    data['__v'] = this._iV;
    data['leadership_user_id'] = this._leadershipUserId;
    data['response_notification_mails'] = this._responseNotificationMails;
    data['ideal_duration'] = this._idealDuration;
    return data;
  }
}
