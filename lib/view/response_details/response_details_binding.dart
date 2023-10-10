import 'package:get/get.dart';
import 'package:servefirst_admin/view/response_details/controller/response_details_controller.dart';

class ResponseDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final int index = Get.arguments as int;
    Get.put(ResponseDetailsController(index));
  }
}