import 'package:get/get.dart';
import 'package:servefirst_admin/view/profile/controller/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController());
  }
}