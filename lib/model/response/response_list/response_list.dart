import 'dart:convert';

import 'package:servefirst_admin/model/response/response_list/responses_data.dart';

List<ResponsesData> responseDataListFromJson(String val) =>
    List<ResponsesData>.from(json.decode(val)['data']
        .map((response) => ResponsesData.fromJson(response))
    );

class ResponseList {
  int? _status;
  String? _message;
  List<ResponsesData>? _data;

  ResponseList({int? status, String? message, List<ResponsesData>? data}) {
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
  List<ResponsesData>? get data => _data;
  set data(List<ResponsesData>? data) => _data = data;

  ResponseList.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = <ResponsesData>[];
      json['data'].forEach((v) {
        _data!.add(new ResponsesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
