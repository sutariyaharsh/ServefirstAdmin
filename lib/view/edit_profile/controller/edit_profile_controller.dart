import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/model/response/login/login.dart';
import 'dart:io';
import 'package:servefirst_admin/model/response/login/user.dart';
import 'package:servefirst_admin/service/local_service/local_login_service.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servefirst_admin/service/remote_service/remote_edit_profile_service.dart';

class EditProfileController extends GetxController {
  static EditProfileController instance = Get.find();
  final LocalLoginService _localLoginService = LocalLoginService();
  Rxn<User> loginUser = Rxn<User>();
  Rx<File?> imageFile = Rx<File?>(null);
  final nameController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final emailController = TextEditingController().obs;

  @override
  void onClose() {
    nameController.close();
    phoneController.close();
    emailController.close();
    super.onClose();
  }

  @override
  void onInit() async {
    await _localLoginService.init();
    print("token :- ${_localLoginService.getToken()}");
    loginUser.value = _localLoginService.getUser();
    nameController.value.text = loginUser.value?.name ?? "";
    phoneController.value.text = loginUser.value?.phone ?? "";
    emailController.value.text = loginUser.value?.email ?? "";
    super.onInit();
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      imageFile.value = img;
      Get.back();
    } on PlatformException catch (e) {
      print(e);
      Get.back();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void editUserProfile({required String name_, required String email_, required String phone_}) async {
    try {
      EasyLoading.show(
        dismissOnTap: false,
      );

      var result = await RemoteEditProfileService().editProfile(
          imageFile: imageFile.value!,
          name: name_,
          email: email_,
          phone: phone_,
          token: _localLoginService.getToken()!);
      if (result.statusCode == 200) {
        var responseBody = await result.stream.bytesToString();
        Login loginResponse = Login.fromJson(jsonDecode(responseBody));
        if (loginResponse.status == 200) {
          loginUser.value = loginResponse.data?.user;
          await _localLoginService.addToken(
              token: loginResponse.data?.token ?? '');
          await _localLoginService.addUser(
              user: loginResponse.data?.user ?? User());
          print("userresponse :- ${jsonEncode(loginResponse.data?.user)}");
          EasyLoading.showSuccess("Profile Updated!");
        }else {
          EasyLoading.showError('Something wrong. Try again!');
        }
      }else {
        EasyLoading.showError('Something wrong. Try again!');
      }
    } catch (e) {
      debugPrint(e.toString());
      EasyLoading.showError('Something wrong. Try again!');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
