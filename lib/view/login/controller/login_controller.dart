import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/model/request/login_request.dart';
import 'package:servefirst_admin/model/response/login/login.dart';
import 'package:servefirst_admin/model/response/login/user.dart';
import 'package:servefirst_admin/route/app_route.dart';
import 'package:servefirst_admin/service/local_service/local_login_service.dart';
import 'package:servefirst_admin/service/remote_service/remote_login_service.dart';

class LoginController extends GetxController {
  static LoginController instance = Get.find();
  Rxn<Login> loginUser = Rxn<Login>();
  final LocalLoginService _localLoginService = LocalLoginService();

  @override
  void onInit() async {
    await _localLoginService.init();
    super.onInit();
  }

  void login({required String email, required String password}) async {
    try {
      EasyLoading.show(
        status: 'Loading...',
        dismissOnTap: false,
      );
      LoginRequest loginRequest =
          LoginRequest(email: email, password: password);

      if (kDebugMode) {
        print('*Login, Request : ${jsonEncode(loginRequest)}');
      }
      var result = await RemoteLoginService().login(loginRequest: loginRequest);
      if (result.statusCode == 200) {
        Login loginResponse = Login.fromJson(jsonDecode(result.body));
        if (loginResponse.status == 200) {
          loginUser.value = loginResponse;
          await _localLoginService.addToken(
              token: loginResponse.data?.token ?? '');
          await _localLoginService.addUser(
              user: loginResponse.data?.user ?? User());
          EasyLoading.showSuccess("Login Success!");
          Get.offAllNamed(AppRoute.dashboard);
        }else {
          EasyLoading.showError('Email/password wrong. Try again!');
        }
      } else {
        EasyLoading.showError('Email/password wrong. Try again!');
      }
    } catch (e) {
      debugPrint(e.toString());
      EasyLoading.showError('Something wrong. Try again!');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
