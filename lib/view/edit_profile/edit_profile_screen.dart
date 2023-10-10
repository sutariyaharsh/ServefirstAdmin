import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servefirst_admin/component/my_button.dart';
import 'package:servefirst_admin/component/profile_text_field.dart';
import 'package:servefirst_admin/constnts/image_strings.dart';
import 'package:servefirst_admin/controller/controllers.dart';
import 'package:servefirst_admin/extention/string_extention.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios,
                        color: AppTheme.lightGrayTextColor),
                    Text(
                      "Edit Profile",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: AppTheme.lightGrayTextColor),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25.h),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Obx(
                        () => editProfileController.imageFile.value != null
                            ? Container(
                                alignment: Alignment.center,
                                width: 120.w,
                                height: 120.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.lightWhite50,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.w,
                                  ),
                                  image: DecorationImage(
                                    image: FileImage(
                                        editProfileController.imageFile.value!),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                            : Container(
                                alignment: Alignment.center,
                                width: 120.w,
                                height: 120.h,
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
                                    imageUrl: profileController
                                            .loginUser.value?.image ??
                                        "",
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      color: Colors.grey.shade300,
                                    ),
                                    errorWidget: (context, url, error) => Center(
                                        child: Image.asset(placeHolderUser)),
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
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 25.h),
                  Obx(
                    ()=> ProfileTextField(
                        labelText: "Name",
                        myController: editProfileController.nameController.value,
                        validation: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "This field can't be empty";
                          }
                          return null;
                        },
                        textInputType: TextInputType.name),
                  ),
                  SizedBox(height: 20.h),
                  Obx(
                    ()=> ProfileTextField(
                        labelText: "Phone Number",
                        myController: editProfileController.phoneController.value,
                        validation: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "This field can't be empty";
                          }
                          return null;
                        },
                        textInputType: TextInputType.phone),
                  ),
                  SizedBox(height: 20.h),
                  Obx(
                    ()=> ProfileTextField(
                        labelText: "Email",
                        myController: editProfileController.emailController.value,
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
                  SizedBox(height: 25.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: MyButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            editProfileController.editUserProfile(
                                name_: editProfileController.nameController.value.text,
                                email_: editProfileController.emailController.value.text,
                                phone_: editProfileController.phoneController.value.text);
                          }
                        },
                        buttonText: "Save"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select an option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildOptionButton('Camera', () {
                Navigator.of(context).pop();
                editProfileController.pickImage(ImageSource.camera);
              }),
              _buildOptionButton('Gallery', () {
                editProfileController.pickImage(ImageSource.gallery);
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