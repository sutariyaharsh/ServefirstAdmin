import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

class MyButton extends StatelessWidget {
  MyButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.width,
    this.height,
    this.fontSize,
  });
  VoidCallback onTap;
  String buttonText;
  double? width;
  double? height;
  double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppTheme.lightPrimaryColor,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonText,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize ?? 14.sp,
                    fontFamily: 'Nexa',
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}