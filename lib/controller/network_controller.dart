import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  static bool isConnected = false;

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) async {
    isConnected = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isConnected = false;
    }
    log("Network : $isConnected", name: "NetworkStream");
  }

  @override
  void dispose() {
    super.dispose();
  }
}
