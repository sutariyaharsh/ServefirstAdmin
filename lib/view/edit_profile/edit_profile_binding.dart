import 'package:get/get.dart';
import 'package:servefirst_admin/view/edit_profile/controller/edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditProfileController());
  }
}