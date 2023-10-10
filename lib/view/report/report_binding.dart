import 'package:get/get.dart';
import 'package:servefirst_admin/view/report/controller/report_controller.dart';

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ReportController());
  }
}