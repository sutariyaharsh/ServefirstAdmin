import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

class ProfileTextField extends StatelessWidget {
   ProfileTextField({
    super.key,
    required this.myController,
    required this.labelText,
     this.validation,
    this.textInputType
  });

  final TextEditingController myController;
  final String labelText;
  TextInputType? textInputType;
   final String? Function(String?)? validation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r), // Adjust the border radius as needed
        border: Border.all(
          color: AppTheme.lightGrayTextColor,
          width: 0.5.sp,
        ),
      ),
      child: TextFormField(
        controller: myController,
        validator: validation ??
                (val) {
              return null;
            },
        style: TextStyle(
          fontSize: 18.sp, // Adjust the font size as needed
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        keyboardType: textInputType,
        cursorColor: AppTheme.lightGrayTextColor,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 18.0, // Adjust the font size as needed
            fontWeight: FontWeight.w500,
            color: AppTheme.lightGrayTextColor,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h), // Adjust the padding as needed
        ),
      ),
    );
  }
}