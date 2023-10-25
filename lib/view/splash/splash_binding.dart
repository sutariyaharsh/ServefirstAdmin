import 'package:get/get.dart';
import 'package:servefirst_admin/view/splash/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
