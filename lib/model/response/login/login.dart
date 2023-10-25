import 'package:servefirst_admin/model/response/login/login_data.dart';

class Login {
  int? _status;
  String? _message;
  LoginData? _data;

  Login({int? status, String? message, LoginData? data}) {
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

  LoginData? get data => _data;

  set data(LoginData? data) => _data = data;

  Login.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
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
