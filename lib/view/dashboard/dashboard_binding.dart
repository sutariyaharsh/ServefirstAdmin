import 'package:get/get.dart';
import 'package:servefirst_admin/view/dashboard/controller/dashboard_controller.dart';
import 'package:servefirst_admin/view/profile/controller/profile_controller.dart';
import 'package:servefirst_admin/view/report/controller/report_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(ReportController());
    Get.put(ProfileController());
  }
}