import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servefirst_admin/constnts/constants.dart';
import 'package:servefirst_admin/controller/controllers.dart';
import 'package:servefirst_admin/model/response/response_list/responses_data.dart';
import 'package:servefirst_admin/theme/app_theme.dart';
import 'package:servefirst_admin/view/survey_responses/model/survey_responses.dart';

class SurveyResponseListViewItem extends StatelessWidget {
  const SurveyResponseListViewItem({
    super.key,
    required this.index,
    required this.surveyName,
    required this.surveyCreatedAt,
    this.onDeleteClick
  });

  final int index;
  final String surveyName;
  final String surveyCreatedAt;
  final VoidCallback? onDeleteClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppTheme.lightPrimaryColor, width: 1.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32.w,
            height: 32.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(width: 1.w, color: AppTheme.lightGrayTextColor)),
            child: Text(
              "${index + 1}",
              style: TextStyle(
                  color: AppTheme.lightGrayTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp),
            ),
          ),
          SizedBox(width: 15.w),
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
                        style: TextStyle(
                            color: AppTheme.lightPrimaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Created at $surveyCreatedAt",
                        maxLines: 1,
                        style: TextStyle(
                            color: AppTheme.lightGrayTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
                if(onDeleteClick != null) GestureDetector(
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
