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
    required this.isPortrait,
  });

  final String valueText;
  final String subtitle;
  final double value;
  final Color trackColor;
  final String title;
  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: isPortrait ? 75 : 130,
              width: isPortrait ? 75 : 130,
              child: CurvedCircularProgressIndicator(
                value: value,
                animationDuration: const Duration(seconds: 1),
                backgroundColor: AppTheme.lightMediumGrayColor,
                color: trackColor,
                strokeWidth: isPortrait ? 9.w : 4.w,
              ),
            ),
            Column(
              children: [
                Text(
                  valueText,
                  style: TextStyle(fontSize: isPortrait ? 14.sp : 9.sp, color: Colors.black, fontWeight: FontWeight.w400),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: isPortrait ? 10.sp : 6.sp, color: AppTheme.lightTextColor, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: isPortrait ? 12.h : 24.h),
        Text(
          title,
          style: TextStyle(fontSize: isPortrait ? 14.sp : 10.sp, fontWeight: FontWeight.w500, color: AppTheme.lightGrayTextColor),
        ),
      ],
    );
  }
}
