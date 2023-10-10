import 'package:get/get.dart';
import 'package:servefirst_admin/view/surveys/controller/surveys_controller.dart';

class SurveysBinding extends Bindings {
  @override
  void dependencies() {
    final int index = Get.arguments as int;
    Get.put(SurveysController(index));
  }
}