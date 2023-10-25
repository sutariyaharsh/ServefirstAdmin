import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servefirst_admin/constnts/text_strings.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

class SyncButton extends StatelessWidget {
  SyncButton({
    super.key,
    required this.onTap, required this.fontSize, required this.borderRadius, required this.iconSize,
  });

  VoidCallback onTap;
  final double fontSize;
  final double borderRadius;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.lightPrimaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Row(
        children: [
          Text(
            sSync,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500, color: AppTheme.lightWhiteTextColor),
          ),
          SizedBox(width: 2.w),
          Icon(Icons.sync, size: iconSize),
        ],
      ),
    );
  }
}
