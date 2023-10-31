import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

class SurveyResponseListViewItem extends StatelessWidget {
  const SurveyResponseListViewItem(
      {super.key, required this.index, required this.surveyName, required this.surveyCreatedAt, this.onDeleteClick, required this.isPortrait});

  final int index;
  final String surveyName;
  final String surveyCreatedAt;
  final VoidCallback? onDeleteClick;
  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isPortrait ? 20.w : 10.w, vertical: isPortrait ? 10.h : 15.h),
      padding: EdgeInsets.symmetric(horizontal: isPortrait ? 15.w : 7.5.w, vertical: isPortrait ? 12.h : 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isPortrait ? 10.r : 20.r),
        border: Border.all(color: AppTheme.lightPrimaryColor, width: isPortrait ? 1.w : 0.5.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: isPortrait ? 32 : 50,
            height: isPortrait ? 32 : 50,
            alignment: Alignment.center,
            decoration:
                BoxDecoration(shape: BoxShape.circle, border: Border.all(width: isPortrait ? 1.w : 0.5.w, color: AppTheme.lightGrayTextColor)),
            child: Text(
              "${index + 1}",
              style: TextStyle(color: AppTheme.lightGrayTextColor, fontWeight: FontWeight.w400, fontSize: isPortrait ? 16.sp : 9.sp),
            ),
          ),
          SizedBox(width: isPortrait ? 15.w : 7.5.w),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        surveyName,
                        style: TextStyle(color: AppTheme.lightPrimaryColor, fontWeight: FontWeight.w600, fontSize: isPortrait ? 18.sp : 12.sp),
                      ),
                      SizedBox(height: isPortrait ? 8.h : 16.h),
                      Text(
                        "Created at $surveyCreatedAt",
                        maxLines: 1,
                        style: TextStyle(color: AppTheme.lightGrayTextColor, fontWeight: FontWeight.w500, fontSize: isPortrait ? 12.sp : 8.sp),
                      ),
                    ],
                  ),
                ),
                if (onDeleteClick != null)
                  GestureDetector(
                    onTap: onDeleteClick,
                    child: Icon(
                      Icons.delete_outline,
                      color: AppTheme.lightGrayTextColor,
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
