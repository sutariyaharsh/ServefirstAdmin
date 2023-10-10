import 'package:hive/hive.dart';
import 'package:servefirst_admin/model/response/location_survey/options.dart';

part 'question.g.dart';
@HiveType(typeId: 8)
class Questions {
  @HiveField(0)
  String? _text;
  @HiveField(1)
  String? _subText;
  @HiveField(2)
  String? _questionType;
  @HiveField(3)
  String? _categoryId;
  @HiveField(4)
  String? _journeyType;
  @HiveField(5)
  int? _maxScore;
  @HiveField(6)
  bool? _required;
  @HiveField(7)
  int? _minOptions;
  @HiveField(8)
  int? _maxOptions;
  @HiveField(9)
  List<Options>? _options;
  @HiveField(10)
  bool? _isNps;
  @HiveField(11)
  String? _sId;

  Questions(
      {String? text,
        String? subText,
        String? questionType,
        String? categoryId,
        String? journeyType,
        int? maxScore,
        bool? required,
        int? minOptions,
        int? maxOptions,
        List<Options>? options,
        bool? isNps,
        String? sId}) {
    if (text != null) {
      this._text = text;
    }
    if (subText != null) {
      this._subText = subText;
    }
    if (questionType != null) {
      this._questionType = questionType;
    }
    if (categoryId != null) {
      this._categoryId = categoryId;
    }
    if (journeyType != null) {
      this._journeyType = journeyType;
    }
    if (maxScore != null) {
      this._maxScore = maxScore;
    }
    if (required != null) {
      this._required = required;
    }
    if (minOptions != null) {
      this._minOptions = minOptions;
    }
    if (maxOptions != null) {
      this._maxOptions = maxOptions;
    }
    if (options != null) {
      this._options = options;
    }
    if (isNps != null) {
      this._isNps = isNps;
    }
    if (sId != null) {
      this._sId = sId;
    }
  }

  String? get text => _text;

  set text(String? text) => _text = text;

  String? get subText => _subText;

  set subText(String? subText) => _subText = subText;

  String? get questionType => _questionType;

  set questionType(String? questionType) => _questionType = questionType;

  String? get categoryId => _categoryId;

  set categoryId(String? categoryId) => _categoryId = categoryId;

  String? get journeyType => _journeyType;

  set journeyType(String? journeyType) => _journeyType = journeyType;

  int? get maxScore => _maxScore;

  set maxScore(int? maxScore) => _maxScore = maxScore;

  bool? get required => _required;

  set required(bool? required) => _required = required;

  int? get minOptions => _minOptions;

  set minOptions(int? minOptions) => _minOptions = minOptions;

  int? get maxOptions => _maxOptions;

  set maxOptions(int? maxOptions) => _maxOptions = maxOptions;

  List<Options>? get options => _options;

  set options(List<Options>? options) => _options = options;

  bool? get isNps => _isNps;

  set isNps(bool? isNps) => _isNps = isNps;

  String? get sId => _sId;

  set sId(String? sId) => _sId = sId;

  Questions.fromJson(Map<String, dynamic> json) {
    _text = json['text'];
    _subText = json['subText'];
    _questionType = json['questionType'];
    _categoryId = json['category_id'];
    _journeyType = json['journey_type'];
    _maxScore = json['maxScore'];
    _required = json['required'];
    _minOptions = json['min_options'];
    _maxOptions = json['max_options'];
    if (json['options'] != null) {
      _options = <Options>[];
      json['options'].forEach((v) {
        _options!.add(new Options.fromJson(v));
      });
    }
    _isNps = json['is_nps'];
    _sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this._text;
    data['subText'] = this._subText;
    data['questionType'] = this._questionType;
    data['category_id'] = this._categoryId;
    data['journey_type'] = this._journeyType;
    data['maxScore'] = this._maxScore;
    data['required'] = this._required;
    data['min_options'] = this._minOptions;
    data['max_options'] = this._maxOptions;
    if (this._options != null) {
      data['options'] = this._options!.map((v) => v.toJson()).toList();
    }
    data['is_nps'] = this._isNps;
    data['_id'] = this._sId;
    return data;
  }
}