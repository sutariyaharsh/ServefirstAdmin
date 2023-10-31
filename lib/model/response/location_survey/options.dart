import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

part 'options.g.dart';

@HiveType(typeId: 9)
class Options {
  @HiveField(0)
  String? _text;
  @HiveField(1)
  int? _value;
  @HiveField(2)
  String? _iconClass;
  @HiveField(3)
  String? _imageUrl;
  @HiveField(4)
  Uint8List? _aImageUrl;
  @HiveField(5)
  bool? _writeIn;
  @HiveField(6)
  bool? _finishSurvey;
  @HiveField(7)
  int? _routeToIndex;
  @HiveField(8)
  String? _sId;

  Options({String? text, int? value, String? iconClass, String? imageUrl, bool? writeIn, bool? finishSurvey, int? routeToIndex, String? sId}) {
    if (text != null) {
      this._text = text;
    }
    if (value != null) {
      this._value = value;
    }
    if (iconClass != null) {
      this._iconClass = iconClass;
    }
    if (imageUrl != null) {
      this._imageUrl = imageUrl;
    }
    if (writeIn != null) {
      this._writeIn = writeIn;
    }
    if (finishSurvey != null) {
      this._finishSurvey = finishSurvey;
    }
    if (routeToIndex != null) {
      this._routeToIndex = routeToIndex;
    }
    if (sId != null) {
      this._sId = sId;
    }
  }

  String? get text => _text;

  set text(String? text) => _text = text;

  int? get value => _value;

  set value(int? value) => _value = value;

  String? get iconClass => _iconClass;

  set iconClass(String? iconClass) => _iconClass = iconClass;

  String? get imageUrl => _imageUrl;

  set imageUrl(String? imageUrl) => _imageUrl = imageUrl;

  Uint8List? get aImageUrl => _aImageUrl;

  set aImageUrl(Uint8List? aImageUrl) => _aImageUrl = aImageUrl;

  bool? get writeIn => _writeIn;

  set writeIn(bool? writeIn) => _writeIn = writeIn;

  bool? get finishSurvey => _finishSurvey;

  set finishSurvey(bool? finishSurvey) => _finishSurvey = finishSurvey;

  int? get routeToIndex => _routeToIndex;

  set routeToIndex(int? routeToIndex) => _routeToIndex = routeToIndex;

  String? get sId => _sId;

  set sId(String? sId) => _sId = sId;

  Options.fromJson(Map<String, dynamic> json) {
    _text = json['text'];
    _value = json['value'];
    _iconClass = json['iconClass'];
    _imageUrl = json['imageUrl'];
    _writeIn = json['write_in'];
    _finishSurvey = json['finish_survey'];
    _routeToIndex = json['route_to_index'];
    _sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this._text;
    data['value'] = this._value;
    data['iconClass'] = this._iconClass;
    data['imageUrl'] = this._imageUrl;
    data['write_in'] = this._writeIn;
    data['finish_survey'] = this._finishSurvey;
    data['route_to_index'] = this._routeToIndex;
    data['_id'] = this._sId;
    return data;
  }
}
