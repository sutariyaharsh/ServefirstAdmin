import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servefirst_admin/component/my_button.dart';
import 'package:servefirst_admin/component/profile_text_field.dart';
import 'package:servefirst_admin/extention/string_extention.dart';
import 'package:servefirst_admin/theme/app_theme.dart';
import 'package:servefirst_admin/view/dashboard/dashboard_screen.dart';
import 'package:servefirst_admin/view/edit_profile/controller/edit_profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final controller = Get.put(EditProfileController());
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return LayoutBuilder(builder: (context, constraints) {
      final isPortrait = constraints.maxWidth < 768;
      return GetBuilder<EditProfileController>(
        builder: (controller) => Scaffold(
          extendBody: true,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: isPortrait ? 15.h : 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: isPortrait ? 15.w : 7.5.w),
                    child: GestureDetector(
                      onTap: () {
                        Get.offAll(() => const DashboardScreen());
                      },
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios, color: AppTheme.lightGrayTextColor),
                          Text(
                            "Edit Profile",
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: isPortrait ? 16.sp : 10.sp, color: AppTheme.lightGrayTextColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: isPortrait ? 25.h : 50.h),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Obx(
                              () => controller.imageFile.value != null
                                  ? Container(
                                      alignment: Alignment.center,
                                      width: isPortrait ? 120 : 150,
                                      height: isPortrait ? 120 : 150,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppTheme.lightWhite50,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1.w,
                                        ),
                                        image: DecorationImage(
                                          image: FileImage(controller.imageFile.value!),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      alignment: Alignment.center,
                                      width: isPortrait ? 120 : 150,
                                      height: isPortrait ? 120 : 150,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppTheme.lightWhite50,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1.w,
                                        ),
                                      ),
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: controller.loginUser.value?.image ?? "",
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 20),
                                            color: Colors.grey.shade300,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Center(child: Image.network("https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png")),
                                        ),
                                      ),
                                    ),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 20,
                              child: GestureDetector(
                                onTap: () {
                                  _showOptionsDialog(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.lightPrimaryColor.withOpacity(0.5)),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: isPortrait ? 25.h : 50.h),
                        Obx(
                          () => ProfileTextField(
                              labelText: "Name",
                              isPortrait: isPortrait,
                              myController: controller.nameController.value,
                              validation: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "This field can't be empty";
                                }
                                return null;
                              },
                              textInputType: TextInputType.name),
                        ),
                        SizedBox(height: isPortrait ? 20.h : 40.h),
                        Obx(
                          () => ProfileTextField(
                              labelText: "Phone Number",
                              isPortrait: isPortrait,
                              myController: controller.phoneController.value,
                              validation: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "This field can't be empty";
                                }
                                return null;
                              },
                              textInputType: TextInputType.phone),
                        ),
                        SizedBox(height: isPortrait ? 20.h : 40.h),
                        Obx(
                          () => ProfileTextField(
                              labelText: "Email",
                              isPortrait: isPortrait,
                              myController: controller.emailController.value,
                              validation: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "This field can't be empty";
                                } else if (!value.isValidEmail) {
                                  return "Please enter valid email";
                                }
                                return null;
                              },
                              textInputType: TextInputType.emailAddress),
                        ),
                        SizedBox(height: isPortrait ? 25.h : 50.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: isPortrait ? 20.w : 10.w),
                          child: MyButton(
                              isPortrait: isPortrait,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  controller.editUserProfile(
                                      name_: controller.nameController.value.text,
                                      email_: controller.emailController.value.text,
                                      phone_: controller.phoneController.value.text);
                                }
                              },
                              buttonText: "Save"),
                        ),
                        SizedBox(height: isPortrait ? 25.h : 50.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select an option', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildOptionButton('Camera', () {
                Navigator.of(context).pop();
                controller.pickImage(ImageSource.camera);
              }),
              _buildOptionButton('Gallery', () {
                controller.pickImage(ImageSource.gallery);
              }),
              _buildOptionButton('Cancel', () {
                // Handle Cancel option
                Navigator.of(context).pop();
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionButton(String text, VoidCallback onPressed) {
    return ListTile(
      title: Text(text),
      onTap: onPressed,
    );
  }
}
