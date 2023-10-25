import 'package:hive/hive.dart';

part 'survey_categories.g.dart';

@HiveType(typeId: 12)
class SurveyCategories {
  @HiveField(0)
  String? _sId;
  @HiveField(1)
  String? _name;

  SurveyCategories({String? sId, String? name}) {
    if (sId != null) {
      this._sId = sId;
    }
    if (name != null) {
      this._name = name;
    }
  }

  String? get sId => _sId;

  set sId(String? sId) => _sId = sId;

  String? get name => _name;

  set name(String? name) => _name = name;

  SurveyCategories.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this._sId;
    data['name'] = this._name;
    return data;
  }
}
