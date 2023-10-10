import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SharedPreferencesController extends GetxController {
  static SharedPreferencesController instance = Get.find();

  final box = GetStorage();

  void saveString(String key, String value) {
    box.write(key, value);
  }

  String getString(String key) {
    dynamic value = box.read(key);
    if (value is String) {
      return value;
    }
    return '';
  }

  void saveBool(String key, bool value) {
    box.write(key, value);
  }

  bool getBool(String key) {
    return box.read(key) as bool? ?? false;
  }

  void saveJson(String key, dynamic value) {
    final jsonString = jsonEncode(value);
    box.write(key, jsonString);
  }

  dynamic getJson(String key) {
    final jsonString = box.read(key) as String?;
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }
}
