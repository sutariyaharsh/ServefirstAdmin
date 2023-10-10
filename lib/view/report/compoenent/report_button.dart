import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

class ReportButton extends StatelessWidget {
  ReportButton({
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 45.w),
        child: Material(
          elevation: 5, // Adjust the elevation value for the shadow effect
          shadowColor: Colors.black.withOpacity(0.3), // Set the desired shadow color
          borderRadius: BorderRadius.circular(22.r),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.lightPrimaryColor,
              borderRadius: BorderRadius.circular(22.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: AppTheme.lightWhiteTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
