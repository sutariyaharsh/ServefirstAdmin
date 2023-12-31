import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/component/my_button.dart';
import 'package:servefirst_admin/component/my_text_field.dart';
import 'package:servefirst_admin/component/svg_icon.dart';
import 'package:servefirst_admin/constnts/image_strings.dart';
import 'package:servefirst_admin/constnts/text_strings.dart';
import 'package:servefirst_admin/extention/string_extention.dart';
import 'package:servefirst_admin/theme/app_theme.dart';
import 'package:servefirst_admin/view/login/controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(LoginController());
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isPortrait = constraints.maxWidth < 768;
      return GetBuilder<LoginController>(
        builder: (controller) => Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: isPortrait ? 115.h : 75.h),
                  Center(child: SvgIcon(assetImage: icTextLogo)),
                  SizedBox(height: isPortrait ? 35.h : 25.h),
                  Text(
                    sWelcome,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: isPortrait ? 24.sp : 14.sp),
                  ),
                  SizedBox(height: 35.h),
                  Text(sLoginTitle, style: TextStyle(fontSize: isPortrait ? 16.sp : 10.sp)),
                  SizedBox(height: 35.h),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: MyTextField(
                            hint: sEmailHint,
                            isPortrait: isPortrait,
                            textEditingController: _emailController,
                            validation: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "This field can't be empty";
                              } else if (!value.isValidEmail) {
                                return "Please enter valid email";
                              }
                              return null;
                            },
                            prefixIcon: Icons.alternate_email,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: MyTextField(
                            obsecureText: true,
                            hint: sPasswordHint,
                            isPortrait: isPortrait,
                            textEditingController: _passwordController,
                            validation: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "This field can't be empty";
                              }
                              return null;
                            },
                            prefixIcon: Icons.lock_outline,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Text(
                            sForgotPassword,
                            style: TextStyle(fontSize: isPortrait ? 16.sp : 8.sp, color: AppTheme.lightPrimaryColor),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: MyButton(
                              isPortrait: isPortrait,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  controller.login(email: _emailController.text, password: _passwordController.text);
                                  /*Navigator.push(context, MaterialPageRoute(builder: (context){
                                return DashboardScreen();
                              }));*/
                                }
                              },
                              fontSize: isPortrait ? 14.sp : 8.sp,
                              buttonText: sContinue),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: isPortrait ? 125.h : 75.h),
                  Text.rich(
                    TextSpan(
                        text: sNotHaveAccount,
                        style: TextStyle(fontFamily: 'Nexa', fontSize: isPortrait ? 16.sp : 10.sp, color: Colors.grey),
                        children: [
                          TextSpan(
                              text: sSignUp,
                              style: TextStyle(
                                  fontFamily: 'Nexa',
                                  fontSize: isPortrait ? 16.sp : 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.lightPrimaryColor))
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
