import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

class FilterPopupMenuItem extends StatelessWidget {
  const FilterPopupMenuItem({
    required this.filterTitle,
    super.key,
    required this.fontSize,
  });

  final String filterTitle;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
      child: Text(
        filterTitle,
        style: TextStyle(fontWeight: FontWeight.w600, color: AppTheme.lightPrimaryColor, fontSize: fontSize),
      ),
    );
  }
}
