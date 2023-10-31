import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servefirst_admin/constnts/text_strings.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

class SyncButton extends StatelessWidget {
  SyncButton({
    super.key,
    required this.onTap,
    required this.isPortrait,
  });

  VoidCallback onTap;
  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.lightPrimaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isPortrait ? 17.r : 34.r),
        ),
      ),
      child: Row(
        children: [
          Text(
            sSync,
            style: TextStyle(fontSize: isPortrait ? 12.sp : 6.5.sp, fontWeight: FontWeight.w500, color: AppTheme.lightWhiteTextColor),
          ),
          SizedBox(width: isPortrait ? 2.w : 1.w),
          Icon(Icons.sync, size: isPortrait ? 18.sp : 8.sp),
        ],
      ),
    );
  }
}
