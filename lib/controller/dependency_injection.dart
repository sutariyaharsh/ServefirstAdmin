import 'package:get/get.dart';
import 'package:servefirst_admin/controller/network_controller.dart';
import 'package:servefirst_admin/controller/offline_survey_controller.dart';

class DependencyInjection {

  static void init() {
    Get.put<NetworkController>(NetworkController(),permanent:true);
    Get.put<OfflineSurveyController>(OfflineSurveyController(),permanent:true);
  }
}