import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servefirst_admin/constnts/text_strings.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

class SyncButton extends StatelessWidget {
  SyncButton({
    super.key,
    required this.onTap,
  });
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.lightPrimaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17.r),
        ),
      ),
      child: Row(
        children: [
          Text(
            sSync,
            style: TextStyle(
                fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppTheme.lightWhiteTextColor),
          ),
          SizedBox(width: 2.w),
          Icon(Icons.sync, size: 18.sp),
        ],
      ),
    );
  }
}