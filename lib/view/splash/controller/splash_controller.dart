import 'package:get/get.dart';
import 'package:servefirst_admin/route/app_route.dart';
import 'package:servefirst_admin/service/local_service/local_login_service.dart';

class SplashController extends GetxController {
  static SplashController instance = Get.find();
  final LocalLoginService _localLoginService = LocalLoginService();
  bool _isNavigated = false;

  @override
  void onInit() async {
    await _localLoginService.init();
    super.onInit();
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    if (!_isNavigated) {
      _isNavigated = true;
      if (_localLoginService.getToken() == null) {
        Get.offAllNamed(AppRoute.login);
      } else {
        Get.offAllNamed(AppRoute.dashboard);
      }
    }
  }
}
