import 'dart:convert';

import 'package:get/get.dart';
import 'package:servefirst_admin/model/response/login/user.dart';
import 'package:servefirst_admin/route/app_route.dart';
import 'package:servefirst_admin/service/local_service/local_login_service.dart';

class ProfileController extends GetxController {
  static ProfileController instance = Get.find();
  final LocalLoginService _localLoginService = LocalLoginService();
  Rxn<User> loginUser = Rxn<User>();
  bool _isNavigated = false;

  @override
  void onInit() async {
    await _localLoginService.init();
    loginUser.value = _localLoginService.getUser();
    print("LoginUser :- ${jsonEncode(loginUser.value)}");
    super.onInit();
  }

  Future logout() async {
    if (!_isNavigated) {
      _isNavigated = true;
      await _localLoginService.clear();
      Get.offAllNamed(AppRoute.login);
    }
  }

  void getLoginUser() async {

  }
}
