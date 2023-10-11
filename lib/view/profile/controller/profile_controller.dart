import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:servefirst_admin/model/response/login/user.dart';
import 'package:servefirst_admin/service/local_service/local_login_service.dart';
import 'package:servefirst_admin/view/login/login_screen.dart';

class ProfileController extends GetxController {
  static ProfileController instance = Get.find();
  final LocalLoginService _localLoginService = LocalLoginService();
  Rxn<User> loginUser = Rxn<User>();
  bool _isNavigated = false;

  @override
  void onInit() async {
    await _localLoginService.init();
    loginUser.value = _localLoginService.getUser();
    log(jsonEncode(loginUser.value), name: "LoginUser");
    super.onInit();
  }

  Future logout() async {
    if (!_isNavigated) {
      _isNavigated = true;
      await _localLoginService.clear();
      Get.offAll(() => const LoginScreen());
    }
  }

  void getLoginUser() async {}
}
