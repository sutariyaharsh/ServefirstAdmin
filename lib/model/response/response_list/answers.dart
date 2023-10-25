import 'package:hive/hive.dart';

part 'answers.g.dart';

@HiveType(typeId: 11)
class Answers {
  @HiveField(0)
  String? _questionId;
  @HiveField(1)
  String? _questionText;
  @HiveField(2)
  String? _questionType;
  @HiveField(3)
  int? _queMaxScore;
  @HiveField(4)
  bool? _isNps;
  @HiveField(5)
  int? _ansMaxScore;
  @HiveField(6)
  bool? _is_Nps;
  @HiveField(7)
  List<String>? _files;
  @HiveField(8)
  dynamic _answer;
  @HiveField(9)
  String? _comment;
  @HiveField(10)
  String? _writeIn;

  Answers(
      {String? questionId,
      String? questionText,
      String? questionType,
      int? queMaxScore,
      bool? isNps,
      int? ansMaxScore,
      bool? is_Nps,
      List<String>? files,
      dynamic answer,
      String? comment,
      String? writeIn}) {
    if (questionId != null) {
      this._questionId = questionId;
    }
    if (questionText != null) {
      this._questionText = questionText;
    }
    if (questionType != null) {
      this._questionType = questionType;
    }
    if (queMaxScore != null) {
      this._queMaxScore = queMaxScore;
    }
    if (isNps != null) {
      this._isNps = isNps;
    }
    if (ansMaxScore != null) {
      this._ansMaxScore = ansMaxScore;
    }
    if (_is_Nps != null) {
      this._is_Nps = _is_Nps;
    }
    if (files != null) {
      this._files = files;
    }
    if (answer != null) {
      this._answer = answer;
    }
    if (comment != null) {
      this._comment = comment;
    }
    if (writeIn != null) {
      this._writeIn = writeIn;
    }
  }

  String? get questionId => _questionId;

  set questionId(String? questionId) => _questionId = questionId;

  String? get questionText => _questionText;

  set questionText(String? questionText) => _questionText = questionText;

  String? get questionType => _questionType;

  set questionType(String? questionType) => _questionType = questionType;

  int? get queMaxScore => _queMaxScore;

  set queMaxScore(int? queMaxScore) => _queMaxScore = queMaxScore;

  bool? get isNps => _isNps;

  set isNps(bool? isNps) => _isNps = isNps;

  int? get ansMaxScore => _ansMaxScore;

  set ansMaxScore(int? ansMaxScore) => _ansMaxScore = ansMaxScore;

  bool? get is_Nps => _is_Nps;

  set is_Nps(bool? is_Nps) => _is_Nps = is_Nps;

  List<String>? get files => _files;

  set files(List<String>? files) => _files = files;

  dynamic? get answer => _answer;

  set answer(dynamic? answer) => _answer = answer;

  String? get comment => _comment;

  set comment(String? comment) => _comment = comment;

  String? get writeIn => _writeIn;

  set writeIn(String? writeIn) => _writeIn = writeIn;

  Answers.fromJson(Map<String, dynamic> json) {
    _questionId = json['questionId'];
    _questionText = json['questionText'];
    _questionType = json['questionType'];
    _queMaxScore = json['queMaxScore'];
    _isNps = json['isNps'];
    _ansMaxScore = json['ansMaxScore'];
    _isNps = json['is_nps'];
    _files = json['files'].cast<String>();
    _answer = json['answer'];
    _comment = json['comment'];
    _writeIn = json['writeIn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this._questionId;
    data['questionText'] = this._questionText;
    data['questionType'] = this._questionType;
    data['queMaxScore'] = this._queMaxScore;
    data['isNps'] = this._isNps;
    data['ansMaxScore'] = this._ansMaxScore;
    data['is_nps'] = this._isNps;
    data['files'] = this._files;
    data['answer'] = this._answer;
    data['comment'] = this._comment;
    data['writeIn'] = this._writeIn;
    return data;
  }
}
