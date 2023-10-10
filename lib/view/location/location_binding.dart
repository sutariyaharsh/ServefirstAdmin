import 'package:get/get.dart';
import 'package:servefirst_admin/view/location/controller/location_controller.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
   Get.put(LocationController());
  }
}