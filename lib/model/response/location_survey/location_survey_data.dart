import 'package:hive_flutter/adapters.dart';
import 'package:servefirst_admin/model/response/location_survey/location.dart';
import 'package:servefirst_admin/model/response/location_survey/survey.dart';

part 'location_survey_data.g.dart';

@HiveType(typeId: 4)
class LocationSurveyData {
  @HiveField(0)
  List<Location>? _location;
  @HiveField(1)
  List<Survey>? _global;

  LocationSurveyData({List<Location>? location, List<Survey>? global}) {
    if (location != null) {
      this._location = location;
    }
    if (global != null) {
      this._global = global;
    }
  }

  List<Location>? get location => _location;
  set location(List<Location>? location) => _location = location;
  List<Survey>? get global => _global;
  set global(List<Survey>? global) => _global = global;

  LocationSurveyData.fromJson(Map<String, dynamic> json) {
    if (json['location'] != null) {
      _location = <Location>[];
      json['location'].forEach((v) {
        _location!.add(new Location.fromJson(v));
      });
    }
    if (json['global'] != null) {
      _global = <Survey>[];
      json['global'].forEach((v) {
        _global!.add(new Survey.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._location != null) {
      data['location'] = this._location!.map((v) => v.toJson()).toList();
    }
    if (this._global != null) {
      data['global'] = this._global!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}