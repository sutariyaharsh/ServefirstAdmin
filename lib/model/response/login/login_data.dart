import 'package:servefirst_admin/model/response/login/user.dart';

class LoginData {
  User? _user;
  String? _token;

  LoginData({User? user, String? token}) {
    if (user != null) {
      this._user = user;
    }
    if (token != null) {
      this._token = token;
    }
  }

  User? get user => _user;
  set user(User? user) => _user = user;
  String? get token => _token;
  set token(String? token) => _token = token;

  LoginData.fromJson(Map<String, dynamic> json) {
    _user = json['user'] != null ? new User.fromJson(json['user']) : json['profile'] != null ? new User.fromJson(json['profile']) : null;
    _token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._user != null) {
      data['user'] = this._user!.toJson();
    }
    data['token'] = this._token;
    return data;
  }
}