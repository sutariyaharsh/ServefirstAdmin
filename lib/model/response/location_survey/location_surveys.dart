import 'package:servefirst_admin/model/response/location_survey/location_survey_data.dart';

class LocationSurveys {
  int? _status;
  String? _message;
  LocationSurveyData? _data;

  LocationSurveys({int? status, String? message, LocationSurveyData? data}) {
    if (status != null) {
      this._status = status;
    }
    if (message != null) {
      this._message = message;
    }
    if (data != null) {
      this._data = data;
    }
  }

  int? get status => _status;
  set status(int? status) => _status = status;
  String? get message => _message;
  set message(String? message) => _message = message;
  LocationSurveyData? get data => _data;
  set data(LocationSurveyData? data) => _data = data;

  LocationSurveys.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? new LocationSurveyData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    return data;
  }
}