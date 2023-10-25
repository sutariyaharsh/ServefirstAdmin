import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

class CircularProgressResponse extends StatelessWidget {
  const CircularProgressResponse({
    super.key,
    required this.valueText,
    required this.subtitle,
    required this.value,
    required this.trackColor,
    required this.title,
  });

  final String valueText;
  final String subtitle;
  final double value;
  final Color trackColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 75.h,
              width: 75.w,
              child: CurvedCircularProgressIndicator(
                value: value,
                animationDuration: const Duration(seconds: 1),
                backgroundColor: AppTheme.lightMediumGrayColor,
                color: trackColor,
                strokeWidth: 9.w,
              ),
            ),
            Column(
              children: [
                Text(
                  valueText,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w400),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 10.sp, color: AppTheme.lightTextColor, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          title,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppTheme.lightGrayTextColor),
        ),
      ],
    );
  }
}
