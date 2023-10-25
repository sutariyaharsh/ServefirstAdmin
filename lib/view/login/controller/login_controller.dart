import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/constnts/constants.dart';
import 'package:servefirst_admin/controller/network_controller.dart';
import 'package:servefirst_admin/model/request/login_request.dart';
import 'package:servefirst_admin/model/response/login/login.dart';
import 'package:servefirst_admin/model/response/login/user.dart';
import 'package:servefirst_admin/service/local_service/local_login_service.dart';
import 'package:servefirst_admin/service/remote_service/remote_login_service.dart';
import 'package:servefirst_admin/view/dashboard/dashboard_screen.dart';

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
    if (NetworkController.isConnected) {
      try {
        EasyLoading.show(
          status: 'Loading...',
          dismissOnTap: false,
        );
        LoginRequest loginRequest = LoginRequest(email: email, password: password);

        log("Request : ${jsonEncode(loginRequest)}", name: "Login");

        var result = await RemoteLoginService().login(loginRequest: loginRequest);
        if (result.statusCode == 200) {
          Login loginResponse = Login.fromJson(jsonDecode(result.body));
          if (loginResponse.status == 200) {
            loginUser.value = loginResponse;
            await _localLoginService.addToken(token: loginResponse.data?.token ?? '');
            await _localLoginService.addUser(user: loginResponse.data?.user ?? User());
            EasyLoading.showSuccess("Login Success!");
            log("Response : ${jsonEncode(loginResponse)}", name: "Login");
            Get.offAll(() => const DashboardScreen());
          } else {
            EasyLoading.showError('Email/password wrong. Try again!');
          }
        } else {
          log("Response : ${result.statusCode} ** ${jsonEncode(result.body)}", name: "Login");
          EasyLoading.showError('Email/password wrong. Try again!');
        }
      } catch (e) {
        log("catch : ${e.toString()}", name: "Login");
      } finally {
        EasyLoading.dismiss();
      }
    } else {
      log('You\'re not connected to a network', name: "Network");
      showNetworkErrorSnackBar();
    }
  }
}
