import 'package:get/get.dart';
import 'package:servefirst_admin/view/survey_responses/controller/survey_responses_controller.dart';

class SurveyResponsesBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SurveyResponsesController());
  }
}