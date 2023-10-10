import 'package:get/get.dart';
import 'package:servefirst_admin/controller/SharedPreferencesController.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SharedPreferencesController());
  }
}