import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

class ProfileTextField extends StatelessWidget {
  ProfileTextField({super.key, required this.myController, required this.labelText, this.validation, this.textInputType, required this.isPortrait});

  final TextEditingController myController;
  final String labelText;
  TextInputType? textInputType;
  final bool isPortrait;
  final String? Function(String?)? validation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isPortrait ? 20.w : 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isPortrait ? 8.r : 16.r), // Adjust the border radius as needed
        border: Border.all(
          color: AppTheme.lightGrayTextColor,
          width: 0.5.w,
        ),
      ),
      child: TextFormField(
        controller: myController,
        validator: validation ??
            (val) {
              return null;
            },
        style: TextStyle(
          fontSize: isPortrait ? 18.sp : 12.sp, // Adjust the font size as needed
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        keyboardType: textInputType,
        cursorColor: AppTheme.lightGrayTextColor,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: isPortrait ? 16.sp : 10.sp, // Adjust the font size as needed
            fontWeight: FontWeight.w500,
            color: AppTheme.lightGrayTextColor,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: isPortrait ? 15.w : 7.5.w, vertical: isPortrait ? 12.h : 24.h), // Adjust the padding as needed
        ),
      ),
    );
  }
}
