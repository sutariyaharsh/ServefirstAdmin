import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:servefirst_admin/service/local_service/local_login_service.dart';
import 'package:servefirst_admin/view/dashboard/dashboard_screen.dart';
import 'package:servefirst_admin/view/login/login_screen.dart';

class SplashController extends GetxController {
  static SplashController instance = Get.find();
  final LocalLoginService _localLoginService = LocalLoginService();
  bool _isNavigated = false;

  @override
  void onInit() async {
    await _localLoginService.init();
    super.onInit();
    await startAnimation();
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    if (!_isNavigated) {
      _isNavigated = true;
      try {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }
        if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
          if (_localLoginService.getToken() == null) {
            Get.offAll(() => const LoginScreen());
          } else {
            Get.off(() => const DashboardScreen());
          }
        } else {
          log("Location permission is not granted");
          showAlertDialog(Get.context);
        }
      } catch (e) {
        log("LocationPermission", error: e);
      }
    }
  }
}

showAlertDialog(context) => showCupertinoDialog<void>(
  context: context,
  barrierDismissible: false,
  builder: (BuildContext context) => CupertinoAlertDialog(
    title: const Text("Permission Denied"),
    content: const Text("Enable location access to provide relevant nearby survey information."),
    actions: <CupertinoDialogAction>[
      CupertinoDialogAction(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text("Cancel"),
      ),
      CupertinoDialogAction(
        isDefaultAction: true,
        onPressed: () => openAppSettings(),
        child: const Text("Settings"),
      )
    ],
  ),
);
