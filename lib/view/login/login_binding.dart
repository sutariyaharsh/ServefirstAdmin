import 'package:get/get.dart';
import 'package:servefirst_admin/view/login/controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}